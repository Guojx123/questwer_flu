import 'dart:io';

import 'package:dio/dio.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:questwer_flu/util/image/image_compress.dart';

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

  Future<String> uploadImage(File file) async {
    var formData = FormData.fromMap({
      'app_id': 'regoo-app',
      'category': 'feedback',
      'file': await MultipartFile.fromFile(
        file.path,
        filename: '${file.path.split('/').last}',
      )
    });

    var response = await _httpClient.post(
      '/file_center/v1/upload',
      data: formData,
    );
    return response.data['data']['path'];
  }

}


