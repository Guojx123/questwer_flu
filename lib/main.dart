import 'package:fish_redux/fish_redux.dart' hide Get;
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/service/shared_preferences.dart';
import 'controller/user_controller.dart';
import 'intl/i18n.dart';
import 'page/fish_route.dart';
import 'page/lead_page.dart';
import 'page/route.dart';
import 'page/welcome/welcome_page.dart';
import 'package:get/get.dart';
import 'service/restart_service.dart';
import 'package:oktoast/oktoast.dart';
import 'service/service_locator.dart';
import 'util/ui/app_dimensions.dart';

void main() => realRunApp();

void realRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 注册系统服务
  setupLocator();

  //初始化LeanCloud服务
  LeanCloud.initialize(
      'gqvQGBzcYDUsxBzHcWRdl2D6-gzGzoHsz', 'YxjvCQ0bPOAktPpRlNGVGcUJ',
      server: 'https://gqvqgbzc.lc-cn-n1-shared.com');
  LCLogger.setLevel(LCLogger.DebugLevel);

  //数据持久化
  await PersistentStorage.init();
  await GetStorage.init();

  runApp(RestartWidget(child: MyApp() // new MaterialApp,
      ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AbstractRoutes fishRoutes = FishRoute.getRoute();
    Map<String, WidgetBuilder> routes = Routes.getRoute();

    return LayoutBuilder(
      builder: (context, constraints) {
        return GetMaterialApp(
          translations: Messages(),
          locale: getLocale(GetStorage().read("deviceLocale")) ??
              Locale("zh", "CN"),
          fallbackLocale: Locale("zh", "CN"),
          home: OKToast(
            position: ToastPosition.bottom,
            child: MaterialApp(
              title: 'Q&A',
              theme: _buildThemeStyle(),
              home: GetBuilder<UserController>(
                init: UserController(),
                builder: (controller) {
                  return controller.isAuth.isTrue ? Welcome() : LeadPage();
                },
              ),

              /// 字体大小不随系统改变
              builder: (context, widget) {
                //屏幕适配
                AppDimensions.init(context);
                AppDimensions.initPortrait();
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget);
              },

              ///去掉右上角DEBUG标签
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute<Object>(
                    builder: (BuildContext context) {
                      Widget widget = fishRoutes.buildPage(
                          settings.name, settings.arguments);
                      if (widget == null) {
                        widget = routes[settings.name](context);
                      }
                      return widget;
                    },
                    settings: settings);
              },
            ),
          ),
        );
      },
    );
  }

  Locale getLocale(String locale) {
    switch (locale) {
      case "English":
        return Locale("en", "US");
        break;
      case "中文":
        return Locale("zh", "CN");
        break;
      case "跟随系统":
        return Get.deviceLocale;
        break;
      case "Follow system":
        return Get.deviceLocale;
        break;
      default:
        return Get.deviceLocale;
        break;
    }
  }

  ThemeData _buildThemeStyle() {
    return ThemeData(
      dividerColor: Color(0xFFDCDCDC),
      primaryColor: Color(0xFF56b0ba),
      backgroundColor: Color(0xFFF3F2F8),
      accentColor: Color(0xFF56b0ba),
      unselectedWidgetColor: Color(0xFFAAAAAA),
      selectedRowColor: Color(0xFFFFF6F6),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
