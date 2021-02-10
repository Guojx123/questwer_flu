import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:questwer_flu/page/lead_pag.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'controller/user_controller.dart';
import 'page/welcome_page.dart';
import 'package:get/get.dart';
import 'service/restart_service.dart';

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
      home: GetBuilder<UserController>(
        init: UserController(),
        // initState: (data) async {
        //   await UserController().isAuthenticated();
        // },
        builder: (controller){
          return controller.isAuth.isTrue ? Welcome() : LeadPage();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();

  @override
  void initState() {
    super.initState();

    menu = PopupMenu(items: [
      // MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
      // MenuItem(title: 'Home', image: Icon(Icons.home, color: Colors.white,)),
      MenuItem(
          title: 'Mail',
          image: Icon(
            Icons.mail,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Power',
          image: Icon(
            Icons.power,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Setting',
          image: Icon(
            Icons.settings,
            color: Colors.white,
          )),
      MenuItem(
          title: 'PopupMenu',
          image: Icon(
            Icons.menu,
            color: Colors.white,
          ))
    ], onClickMenu: onClickMenu, onDismiss: onDismiss, maxColumn: 2);
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: Container(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: MaterialButton(
                height: 45.0,
                key: btnKey,
                onPressed: maxColumn,
                child: Text('Show Menu1'),
              ),
            ),
            Container(
              child: MaterialButton(
                key: btnKey2,
                height: 45.0,
                onPressed: customBackground,
                child: Text('Show Menu2'),
              ),
            ),
            Container(
              child: MaterialButton(
                key: btnKey3,
                height: 45.0,
                onPressed: onDismissOnlyBeCalledOnce,
                child: Text('Show Menu3'),
              ),
            ),
            Container(
              child: MaterialButton(
                height: 30.0,
                child: Text('Gestures Demo'),
                onPressed: onGesturesDemo,
              ),
            )
          ],
        ),
      ),
    );
  }

  void onDismissOnlyBeCalledOnce() {
    menu.show(widgetKey: btnKey3);
  }

  void onGesturesDemo() {
    menu.dismiss();
    return;
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => GestureDemo()),
    // );
  }

  void checkState(BuildContext context) {
    final snackBar = new SnackBar(content: new Text('这是一个SnackBar!'));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void maxColumn() {
    PopupMenu menu = PopupMenu(
      backgroundColor: Colors.teal,
      lineColor: Colors.tealAccent,
        maxColumn: 2,
        items: [
          MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
          MenuItem(
              title: 'Home',
              // textStyle: TextStyle(fontSize: 10.0, color: Colors.tealAccent),
              image: Icon(
                Icons.home,
                color: Colors.white,
              )),
          MenuItem(
              title: 'Mail',
              image: Icon(
                Icons.mail,
                color: Colors.white,
              )),
          MenuItem(
              title: 'Power',
              image: Icon(
                Icons.power,
                color: Colors.white,
              )),
          MenuItem(
              title: 'Setting',
              image: Icon(
                Icons.settings,
                color: Colors.white,
              )),
          MenuItem(
              title: 'PopupMenu',
              image: Icon(
                Icons.menu,
                color: Colors.white,
              ))
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey);
  }

  //
  void customBackground() {
    PopupMenu menu = PopupMenu(
      // backgroundColor: Colors.teal,
      // lineColor: Colors.tealAccent,
      // maxColumn: 2,
        items: [
          MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
          MenuItem(
              title: 'Home',
              // textStyle: TextStyle(fontSize: 10.0, color: Colors.tealAccent),
              image: Icon(
                Icons.home,
                color: Colors.white,
              )),
          MenuItem(
              title: 'Mail',
              image: Icon(
                Icons.mail,
                color: Colors.white,
              )),
          MenuItem(
              title: 'Power',
              image: Icon(
                Icons.power,
                color: Colors.white,
              )),
          MenuItem(
              title: 'Setting',
              image: Icon(
                Icons.settings,
                color: Colors.white,
              )),
          MenuItem(
              title: 'PopupMenu',
              image: Icon(
                Icons.menu,
                color: Colors.white,
              ))
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey2);
  }
}

