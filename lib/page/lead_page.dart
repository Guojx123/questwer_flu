import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questwer_flu/page/home/home_page.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/theme/size.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/lead_page_layout.dart';

class LeadPage extends StatefulWidget {
  final String title;

  LeadPage({Key key, this.title}) : super(key: key);

  @override
  _LeadPageState createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage> {

  PageController pageController;
  ValueNotifier<double> notifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: notifier,
              builder: (context, value, widget) {
                return Container(
                  color: Color.lerp(
                    Color(0xD040A5B9),
                    Color(0xD0FFDE59),
                    notifier.value,
                  ),
                );
              },
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              // toolbarHeight: DefaultSize.defaultPadding * 4,
              brightness: Brightness.dark,
              elevation: 0,
              title: Text(
                "Hi !  ${PersistentStorage.get("nickname")}.",
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: ColorsTheme.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DefaultSize.defaultPadding),
                    child: Icon(
                      Icons.settings,
                      color: ColorsTheme.white,
                    ))
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.89,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTitle(),
                  Expanded(
                    child: PageView(
                      physics: new BouncingScrollPhysics(),
                      controller: pageController
                        ..addListener(() {
                          notifier.value = pageController.offset / pageController.position.maxScrollExtent;
                        }),
                      children: <Widget>[
                        PageWidget(
                          'Hall',
                          'Show Flutter Widgets in category',
                          'assets/hall_bg.jpg',
                              () {
                            Get.to(HomePage());
                          },
                        ),
                        PageWidget(
                          'Challenge',
                          'Show UI Pattern in most Apps',
                          'assets/challenge_bg.png',
                              () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => SkillMainPage()));
                          },
                        ),
                        PageWidget(
                          'Mine',
                          'Show Flutter Utils',
                          'assets/mine_bg.jpg',
                              () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => UtilMainPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                  _buildLinearProgress(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle({String title = "Example Title"}){
    return Text(title);
  }

  Widget _buildLinearProgress(){
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 48, right: 48),
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, widget) {
          return LinearProgressIndicator(
            value: notifier.value,
            valueColor: AlwaysStoppedAnimation(
              Color.lerp(
                Color(0xD040A5B9),
                Color(0xD0FFDE59),
                notifier.value,
              ),
            ),
          );
        },
      ),
    );
  }
}