import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///created by Ray on 2021.3.10
///根据[compressionRatio]或者[maxBytes]来缩放图片，以减少内存占用
///如果[compressionRatio]不为空则按[compressionRatio]比例来缩放图片宽高
///否则按[maxBytes]最大值处理。默认500KB
class AutoResizeImage extends ImageProvider<_SizeAwareCacheKey> {
  const AutoResizeImage(
      this.imageProvider, {
        this.compressionRatio,
        this.maxBytes = 500 << 10,
      }) : assert(compressionRatio != null || maxBytes != null);

  /// The [ImageProvider] that this class wraps.
  final ImageProvider imageProvider;

  final int maxBytes;

  final double compressionRatio;

  @override
  ImageStreamCompleter load(_SizeAwareCacheKey key, DecoderCallback decode) {
    final DecoderCallback decodeResize = (Uint8List bytes,
        {int cacheWidth, int cacheHeight, bool allowUpscaling}) {
      assert(
      cacheWidth == null && cacheHeight == null && allowUpscaling == null,
      'ResizeImage cannot be composed with another ImageProvider that applies '
          'cacheWidth, cacheHeight, or allowUpscaling.');
      return instantiateImageCodec(
        bytes,
        compressionRatio: compressionRatio,
        maxBytes: maxBytes,
      );
    };
    final ImageStreamCompleter completer =
    imageProvider.load(key.providerCacheKey, decodeResize);
    if (!kReleaseMode) {
      completer.debugLabel =
      '${completer.debugLabel} - Resized(compressionRatio: ${key.compressionRatio} maxBytes${key.maxBytes})';
    }
    return completer;
  }

  @override
  Future<_SizeAwareCacheKey> obtainKey(ImageConfiguration configuration) {
    Completer<_SizeAwareCacheKey> completer;
    // If the imageProvider.obtainKey future is synchronous, then we will be able to fill in result with
    // a value before completer is initialized below.
    SynchronousFuture<_SizeAwareCacheKey> result;
    imageProvider.obtainKey(configuration).then((Object key) {
      if (completer == null) {
        // This future has completed synchronously (completer was never assigned),
        // so we can directly create the synchronous result to return.
        result = SynchronousFuture<_SizeAwareCacheKey>(
            _SizeAwareCacheKey(key, compressionRatio, maxBytes));
      } else {
        // This future did not synchronously complete.
        completer.complete(_SizeAwareCacheKey(key, compressionRatio, maxBytes));
      }
    });
    if (result != null) {
      return result;
    }
    // If the code reaches here, it means the imageProvider.obtainKey was not
    // completed sync, so we initialize the completer for completion later.
    completer = Completer<_SizeAwareCacheKey>();
    return completer.future;
  }

  Future<Codec> instantiateImageCodec(
      Uint8List list, {
        double compressionRatio,
        int maxBytes,
      }) async {
    final ImmutableBuffer buffer = await ImmutableBuffer.fromUint8List(list);
    final ImageDescriptor descriptor = await ImageDescriptor.encoded(buffer);
    int targetWidth = descriptor.width, targetHeight = descriptor.height;
    if (compressionRatio != null) {
      assert(compressionRatio > 0 && compressionRatio <= 1);
      if (compressionRatio == 1) {
        targetWidth = descriptor.width;
        targetHeight = descriptor.height;
      } else {
        IntSize size = resizeWH(
            descriptor.width,
            descriptor.height,
            (descriptor.width * descriptor.height * 4 * compressionRatio)
                .toInt());
        targetWidth = size.width;
        targetHeight = size.height;
      }
    } else {
      IntSize size = resizeWH(descriptor.width, descriptor.height, maxBytes);
      targetWidth = size.width;
      targetHeight = size.height;
    }
    if (!kReleaseMode) {
      print('origin size: ${descriptor.width}*${descriptor.height} '
          'scaled size: $targetWidth*$targetHeight'
          ' scale : ${descriptor.width / targetWidth}');
    }
    return descriptor.instantiateCodec(
      targetWidth: targetWidth,
      targetHeight: targetHeight,
    );
  }

  IntSize resizeWH(int width, int height, int maxSize) {
    double ratio = width / height;
    int maxSize_1_4 = maxSize >> 2;
    int targetHeight = sqrt(maxSize_1_4 / ratio).floor();
    int targetWidth = (ratio * targetHeight).floor();
    return IntSize(targetWidth, targetHeight);
  }
}

@immutable
class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

@immutable
class _SizeAwareCacheKey {
  const _SizeAwareCacheKey(
      this.providerCacheKey,
      this.compressionRatio,
      this.maxBytes,
      );

  final Object providerCacheKey;

  final int maxBytes;

  final double compressionRatio;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is _SizeAwareCacheKey &&
        other.providerCacheKey == providerCacheKey &&
        other.maxBytes == maxBytes &&
        other.compressionRatio == compressionRatio;
  }

  @override
  int get hashCode => hashValues(providerCacheKey, maxBytes, compressionRatio);
}