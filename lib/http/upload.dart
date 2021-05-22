import 'package:dio/dio.dart';
import 'package:questwer_flu/util/image/image_compress.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UploadProvider {
  Dio _httpClient;
  dynamic uploadConfig;

  UploadProvider() {
    var options = BaseOptions(
      baseUrl: 'https://',
      connectTimeout: 10 * 1000,
    );
    _httpClient = Dio(options);

  }

  Future<List<String>> uploadImage(List<AssetEntity> list) async {
    var imageList = <String>[];

    for (var i = 0; i < list.length; i++) {
      var originFile = await list[i].originFile;

      var file = await ImageCompress().compressImage(originFile);

      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path, //图片路径
          filename: '${file.path.split('/').last}',
          // contentType: MediaType('image', '$suffix')
        )
      });

      var response = await _httpClient.post(
        '/file_center/v1/upload',
        data: formData,
      );
      var imageLink = response.data['data']['path'];
      imageList.add(imageLink);
    }
    return imageList;
  }



}


