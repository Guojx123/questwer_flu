import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/theme/size.dart';
import 'page/lead_pag.dart';
import 'service/restartService.dart';
import 'theme/color.dart';

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

class Welcome extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blueGrey.withOpacity(0.5),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DefaultSize.defaultPadding),
                child: Column(
                  children: [
                    Spacer(flex: 1),
                    //2/6
                    Text(
                      "Let's Play a Q&A.",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    // Text("Trust me, it must be fun",style: Theme.of(context).textTheme.subtitle1.copyWith(
                    //     color: Colors.white)),
                    Spacer(),
                    // 1/6
                    TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: "Enter your nickname",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    Spacer(),
                    // 1/6
                    GestureDetector(
                      onTap: () {
                        if (textEditingController.text != null &&
                            textEditingController.text.length > 0) {
                          Get.to(LeadPage());
                        } else {
                          Get.snackbar("Tips", "Please enter a nickname",
                              icon: Icon(Icons.messenger),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundGradient: ColorsTheme.kPrimaryGradient);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                            horizontal: DefaultSize.defaultPadding),
                        padding: EdgeInsets.all(DefaultSize.defaultPadding),
                        // 15
                        decoration: BoxDecoration(
                          gradient: ColorsTheme.kWelcomeGradient,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          "Go",
                          style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Spacer(flex: 2),
                    // it will take 2/6 spaces
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
