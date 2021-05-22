import 'dart:io';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;

class ImageCompress {
  Future<File> compressImage(File file) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    var rand = Math.Random().nextInt(10000);

    var image = Im.decodeImage(file.readAsBytesSync());
    var smallerImage = Im.copyResize(image, width: 720);

    var compressedImage = File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(smallerImage, quality: 85));
    return compressedImage;
  }
}
