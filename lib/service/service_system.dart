import 'dart:io';
import 'dart:ui' as ui show window;
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:package_info/package_info.dart';

class SystemService {
  __DeviceInfo _deviceInfo;
  __ScreenInfo _screenInfo;

  SystemService(
    BuildContext context, {
    double designW,
    double designH,
    double designD,
  }) {
    _screenInfo = __ScreenInfo(designW: designW, designH: designH, designD: designD);
    _deviceInfo = __DeviceInfo(context);
  }

  __DeviceInfo get deviceInfo => _deviceInfo;

  __ScreenInfo get screenInfo => _screenInfo;

}

/// Screen Util.
class __ScreenInfo {

  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double _screenDensity = 0.0;
  double _statusBarHeight = 0.0;
  double _bottomBarHeight = 0.0;
  double _appBarHeight = 0.0;
  MediaQueryData _mediaQueryData;

  __ScreenInfo({
    double designW,
    double designH,
    double designD,
  }) {

    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    if (_mediaQueryData != mediaQuery) {
      _mediaQueryData = mediaQuery;
      _screenWidth = mediaQuery.size.width * mediaQuery.devicePixelRatio;
      _screenHeight = mediaQuery.size.height * mediaQuery.devicePixelRatio;
      _screenDensity = mediaQuery.devicePixelRatio;
      _statusBarHeight = mediaQuery.padding.top;
      _bottomBarHeight = mediaQuery.padding.bottom;
      _appBarHeight = kToolbarHeight;
    }
  }

  /// screen width
  /// 屏幕 宽
  double get screenWidth => _screenWidth;

  /// screen height
  /// 屏幕 高
  double get screenHeight => _screenHeight;

  /// 获取屏幕分辨率
  String getScreenSize(){
    return "${screenWidth.round()}x${screenHeight.round()}";
  }

  /// appBar height
  /// appBar 高
  double get appBarHeight => _appBarHeight;

  /// screen density
  /// 屏幕 像素密度
  double get screenDensity => _screenDensity;

  /// status bar Height
  /// 状态栏高度
  double get statusBarHeight => _statusBarHeight;

  /// bottom bar Height
  double get bottomBarHeight => _bottomBarHeight;

  /// media Query Data
  MediaQueryData get mediaQueryData => _mediaQueryData;

}

class __DeviceInfo {
  String device_id; // 用户设备 ID
  String package_id; // 包名
  String version_name; // App版本号
  String system_version_name; // 系统版本号
  String platform; // 平台，如 android，ios
  String userId; // 用户 ID
  String timestamp; // 当前时间戳（单位：毫秒）
  String time_zone; // 时区
  String country_code;
  String language; // 语言
  String screen_resolution; // 屏幕分辨率

  __DeviceInfo(BuildContext context) {
    language = Localizations.localeOf(context).languageCode;
    country_code = Localizations.localeOf(context).countryCode;
  }

  /// 获取设备 id
  Future<String> getPlatformId() async {
    if (device_id != null) {
      return device_id;
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device_id = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      device_id = iosInfo.identifierForVendor;
    }
    return device_id;
  }

  /// 获取包名
  Future<String> getPackageName() async {
    if (package_id != null) {
      return package_id;
    }
    PackageInfo info = await PackageInfo.fromPlatform();
    package_id = info.packageName;
    return package_id;
  }

  /// 获取App版本号
  Future<String> getAppVersion() async {
    if (version_name != null) {
      return version_name;
    }
    PackageInfo info = await PackageInfo.fromPlatform();
    version_name = info.version;
    return version_name;
  }

  /// 获取系统版本号
  Future<String> getSystemVersion() async {
    if (system_version_name != null) {
      return system_version_name;
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      system_version_name = androidInfo.version.release;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      system_version_name = iosInfo.systemVersion;
    }
    return system_version_name;
  }

  /// 获取平台
  String getPlatform() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    }
    return '';
  }

  /// 获取当前时间戳(毫秒)
  String getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// 获取当前时区
  Future<String> getTimeZone() async {
    if (time_zone != null) {
      return time_zone;
    }
    time_zone = await FlutterNativeTimezone.getLocalTimezone();
    return time_zone;
  }

  String getCountryCode({BuildContext context}) {
    if (country_code != null) {
      return country_code;
    }
    if (context != null) {
      country_code = Localizations.localeOf(context).countryCode;
    }
    return country_code;
  }

  /// 获取当前语言
  String getLanguage({BuildContext context}) {
    if (language != null) {
      return language;
    }
    if (context != null) {
      language = Localizations.localeOf(context).languageCode;
    }
    return language;
  }



}
