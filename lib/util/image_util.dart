import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img_lib;
import 'package:questwer_flu/service/logger.dart';

const shift = (0xFF << 24);

/// Image Util.
class ImageUtil {
  ImageStreamListener _listener;
  ImageStream _imageStream;

  /// get image width height，load error throw exception.（unit px）
  /// 获取图片宽高，加载错误会抛出异常.（单位 px）
  /// image
  /// url network
  /// local url , package
  Future<Rect> getImageWH({
    Image image,
    String url,
    String localUrl,
    String package,
    ImageConfiguration configuration,
  }) {
    Completer<Rect> completer = Completer<Rect>();
    _listener = ImageStreamListener(
      (ImageInfo info, bool synchronousCall) {
        _imageStream.removeListener(_listener);
        if (!completer.isCompleted) {
          completer.complete(Rect.fromLTWH(
              0, 0, info.image.width.toDouble(), info.image.height.toDouble()));
        }
      },
      onError: (dynamic exception, StackTrace stackTrace) {
        _imageStream.removeListener(_listener);
        if (!completer.isCompleted) {
          completer.completeError(exception, stackTrace);
        }
      },
    );

    if (image == null &&
        (url == null || url.isEmpty) &&
        (localUrl == null || localUrl.isEmpty)) {
      return Future.value(Rect.zero);
    }
    Image img = image != null
        ? image
        : ((url != null && url.isNotEmpty)
            ? Image.network(url)
            : Image.asset(localUrl, package: package));
    _imageStream = img.image.resolve(configuration ?? ImageConfiguration());
    _imageStream.addListener(_listener);
    return completer.future;
  }

  static Future<img_lib.Image> convertRgba8888toImage(var image) async {
    try {
      final int width = image.width;
      final int height = image.height;
      var img = img_lib.Image(width, height);

      const int byteRgba = (0x00014210 & 0x0F000) >> 12;
      const int rShift = (0x00014210 & 0x00F00) >> 8;
      const int gShift = (0x00014210 & 0x000F0) >> 4;
      const int bShift = (0x00014210 & 0x0000F);
      var rgb = image.planes[0].bytes;
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final int index = y * width + x;

          final r = rgb[index * byteRgba + rShift] & 0xFF;
          final g = rgb[index * byteRgba + gShift] & 0xFF;
          final b = rgb[index * byteRgba + bShift] & 0xFF;
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          img.data[index] = shift | (b << 16) | (g << 8) | r;
        }
      }
      return img;
    } catch (e) {
      Logger.e("convertRgba8888toImage >>>>>>>>>>>> ERROR:" + e.toString());
    }
    return null;
  }

  static Future<img_lib.Image> convertYUV420toImage(var image) async {
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel;

      // imgLib -> Image package from https://pub.dartlang.org/packages/image
      var img = img_lib.Image(width, height); // Create Image buffer

      // Fill image buffer with plane[0] from YUV420_888
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final int uvIndex =
              uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
          final int index = y * width + x;

          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          // Calculate pixel color
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
              .round()
              .clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          img.data[index] = shift | (b << 16) | (g << 8) | r;
        }
      }

      return img;
    } catch (e) {
      Logger.e("convertYUV420toImage >>>>>>>>>>>> ERROR:" + e.toString());
    }
    return null;
  }
}
