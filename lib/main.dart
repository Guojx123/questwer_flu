import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'file:///E:/questwer_flu/lib/page/home/home_page.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'controller/user_controller.dart';
import 'page/welcome_page.dart';
import 'package:get/get.dart';
import 'service/restart_service.dart';
import 'package:oktoast/oktoast.dart';

void main() => realRunApp();

void realRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //初始化LeanCloud服务
  LeanCloud.initialize(
      'gqvQGBzcYDUsxBzHcWRdl2D6-gzGzoHsz', 'YxjvCQ0bPOAktPpRlNGVGcUJ',
      server: 'https://gqvqgbzc.lc-cn-n1-shared.com');
  LCLogger.setLevel(LCLogger.DebugLevel);

  //数据持久化
  await PersistentStorage.init();

  runApp(RestartWidget(child: MyApp() // new MaterialApp,
      ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: OKToast(
        position: ToastPosition.bottom,
        child: MaterialApp(
          title: 'Q&A',
          theme: _buildThemeStyle(),
          home: GetBuilder<UserController>(
            init: UserController(),
            // initState: (data) async {
            //   await UserController().isAuthenticated();
            // },
            builder: (controller) {
              return controller.isAuth.isTrue ? Welcome() : HomePage();
            },
          ),
          /// 字体大小不随系统改变
          builder: (context, widget) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget);
          },
        ),
      ),
    );
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
