import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'controller/user_controller.dart';
import 'page/welcome_page.dart';
import 'package:get/get.dart';
import 'service/restartService.dart';

void main() => realRunApp();

void realRunApp() async {
  //初始化LeanCloud服务
  LeanCloud.initialize(
      'gqvQGBzcYDUsxBzHcWRdl2D6-gzGzoHsz', 'YxjvCQ0bPOAktPpRlNGVGcUJ',
      server: 'https://gqvqgbzc.lc-cn-n1-shared.com');
  LCLogger.setLevel(LCLogger.DebugLevel);
  WidgetsFlutterBinding.ensureInitialized();

  await PersistentStorage.init();

  runApp(
      RestartWidget(
          child: MyApp() // new MaterialApp,
      ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Q&A',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.teal[300]),
      home: Welcome(),
    );
  }
}
