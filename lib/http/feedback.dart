import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class FeedBack {
  Dio _httpClient;
  dynamic feedbackConfig;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  FeedBack() {
    var options = BaseOptions(
      baseUrl: 'https://',
      connectTimeout: 10 * 1000,
    );
    _httpClient = Dio(options);
  }

  Future sendFeedBack(BuildContext context, String type, String msg,
      {List pics, String email}) async {}
}
