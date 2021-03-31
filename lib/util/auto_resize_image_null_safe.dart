// import 'dart:async';
// import 'dart:math';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// /// Instructs Flutter to decode the image at the specified dimensions
// /// instead of at its native size.
// ///
// /// This allows finer control of the size of the image in [ImageCache] and is
// /// generally used to reduce the memory footprint of [ImageCache].
// ///
// /// The decoded image may still be displayed at sizes other than the
// /// cached size provided here.
// class AutoResizeImage extends ImageProvider<_SizeAwareCacheKey> {
//    AutoResizeImage(
//       this.imageProvider, {
//         required this.compressionRatio,
//         this.maxBytes = 500 << 10,
//         required this.width,
//         required this.height,
//         this.allowUpscaling = false,
//          required this.buffer,
//          required this.completer,
//          required this.descriptor
//       }) : assert((
//       compressionRatio > 0 &&
//       compressionRatio < 1) ||
//       (maxBytes > 0));
//
//   /// The [ImageProvider] that this class wraps.
//   final ImageProvider imageProvider;
//
//   /// [ExtendedResizeImage] will compress the image to a size
//   /// that is smaller than [maxBytes]. The default size is 500KB.
//   final int maxBytes;
//
//   /// The image`s size will resize to original * [compressionRatio].
//   /// It's ExtendedResizeImage`s first pick.
//   /// The compressionRatio`s range is from 0.0 (exclusive), to
//   /// 1.0 (exclusive).
//   final double compressionRatio;
//
//   /// The width the image should decode to and cache.
//   final int width;
//
//   /// The height the image should decode to and cache.
//   final int height;
//
//   /// Whether the [width] and [height] parameters should be clamped to the
//   /// intrinsic width and height of the image.
//   ///
//   /// In general, it is better for memory usage to avoid scaling the image
//   /// beyond its intrinsic dimensions when decoding it. If there is a need to
//   /// scale an image larger, it is better to apply a scale to the canvas, or
//   /// to use an appropriate [Image.fit].
//   final bool allowUpscaling;
//
//   ImmutableBuffer buffer;
//   ImageDescriptor descriptor;
//   ImageStreamCompleter completer;
//
//
//   @override
//   ImageStreamCompleter load(_SizeAwareCacheKey key, DecoderCallback decode){
//     final DecoderCallback decodeResize = getImageCodec(key.maxBytes as Uint8List,cacheWidth: key.width,cacheHeight: key.height,allowUpscaling: true);
//     completer = imageProvider.load(
//       key.providerCacheKey,
//       decodeResize,
//     );
//     if (!kReleaseMode) {
//       completer.debugLabel =
//       '${completer.debugLabel} - Resized(compressionRatio:'
//           ' ${key.compressionRatio} maxBytes:${key.maxBytes} size:${key.width}*${key.height})';
//     }
//     return completer;
//   }
//
//   getImageCodec(
//       Uint8List bytes, {
//         required int cacheWidth,
//         required int cacheHeight,
//         required bool allowUpscaling,
//       }) async{
//     return await _instantiateImageCodec(
//       bytes,
//       compressionRatio,
//       maxBytes,
//       width,
//       height,
//     );
//   }
//
//   @override
//   Future<_SizeAwareCacheKey> obtainKey(ImageConfiguration configuration) {
//     Completer<_SizeAwareCacheKey>? completer;
//     // If the imageProvider.obtainKey future is synchronous, then we will be able to fill in result with
//     // a value before completer is initialized below.
//     SynchronousFuture<_SizeAwareCacheKey> result;
//     imageProvider.obtainKey(configuration).then((Object key) {
//       if (completer == null) {
//         // This future has completed synchronously (completer was never assigned),
//         // so we can directly create the synchronous result to return.
//         result = SynchronousFuture<_SizeAwareCacheKey>(
//             _SizeAwareCacheKey(key, compressionRatio, maxBytes, width, height));
//         return result;
//       } else {
//         // This future did not synchronously complete.
//         completer.complete(
//             _SizeAwareCacheKey(key, compressionRatio, maxBytes, width, height));
//       }
//     });
//     // If the code reaches here, it means the imageProvider.obtainKey was not
//     // completed sync, so we initialize the completer for completion later.
//     completer = Completer<_SizeAwareCacheKey>();
//     return completer.future;
//   }
//
//   Future<Codec> _instantiateImageCodec(
//       Uint8List list,
//         double compressionRatio,
//         int maxBytes,
//         int targetWidth,
//         int targetHeight,
//       ) async {
//     buffer = await ImmutableBuffer.fromUint8List(list);
//     descriptor = await ImageDescriptor.encoded(buffer);
//     if (compressionRatio != null) {
//       final size = _resize(
//         descriptor.width,
//         descriptor.height,
//         (descriptor.width * descriptor.height * 4 * compressionRatio).toInt(),
//       );
//       targetWidth = size.width;
//       targetHeight = size.height;
//     } else if (maxBytes != null) {
//       final size = _resize(
//         descriptor.width,
//         descriptor.height,
//         maxBytes,
//       );
//       targetWidth = size.width;
//       targetHeight = size.height;
//     } else if (!allowUpscaling) {
//       if (targetWidth > descriptor.width) {
//         targetWidth = descriptor.width;
//       }
//       if (targetHeight > descriptor.height) {
//         targetHeight = descriptor.height;
//       }
//     }
//     return descriptor.instantiateCodec(
//       targetWidth: targetWidth,
//       targetHeight: targetHeight,
//     );
//   }
//
//   /// Calculate fittest size.
//   /// [width] The image's original width.
//   /// [height] The image's original height.
//   /// [maxBytes] The size that image will resize to.
//   ///
//   IntSize _resize(int width, int height, int maxBytes) {
//     final ratio = width / height;
//     final maxSize_1_4 = maxBytes >> 2;
//     final targetHeight = sqrt(maxSize_1_4 / ratio).floor();
//     final targetWidth = (ratio * targetHeight).floor();
//     return IntSize(targetWidth, targetHeight);
//   }
// }
//
// @immutable
// class IntSize {
//   const IntSize(this.width, this.height);
//
//   final int width;
//   final int height;
// }
//
// @immutable
// class _SizeAwareCacheKey {
//   const _SizeAwareCacheKey(
//       this.providerCacheKey,
//       this.compressionRatio,
//       this.maxBytes,
//       this.width,
//       this.height,
//       );
//
//   final Object providerCacheKey;
//
//   final int maxBytes;
//
//   final double compressionRatio;
//
//   final int width;
//
//   final int height;
//
//   @override
//   bool operator ==(Object other) {
//     if (other.runtimeType != runtimeType) {
//       return false;
//     }
//     return other is _SizeAwareCacheKey &&
//         other.providerCacheKey == providerCacheKey &&
//         other.maxBytes == maxBytes &&
//         other.compressionRatio == compressionRatio &&
//         other.width == width &&
//         other.height == height;
//   }
//
//   @override
//   int get hashCode => hashValues(
//     providerCacheKey,
//     maxBytes,
//     compressionRatio,
//     width,
//     height,
//   );
// }