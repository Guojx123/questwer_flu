import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'page/welcome_page.dart';
import 'service/restartService.dart';

void main() => realRunApp();

void realRunApp() async {
  //初始化LeanCloud服务
  LeanCloud.initialize(
      'gqvQGBzcYDUsxBzHcWRdl2D6-gzGzoHsz', 'YxjvCQ0bPOAktPpRlNGVGcUJ',
      server: 'https://gqvqgbzc.lc-cn-n1-shared.com');
  LCLogger.setLevel(LCLogger.DebugLevel);

  runApp(RestartWidget(child: MyApp() // new MaterialApp,
      ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
