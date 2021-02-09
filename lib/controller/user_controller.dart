import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';

class UserController extends GetxController{

  RxInt isAuth = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  isAuthenticated() async {
    LCUser currentUser = await LCUser.getCurrent();
    if (currentUser != null) {
      // 跳到首页
      isAuth = 0.obs;
    } else {
      // 显示注册、登录或欢迎页面
      isAuth = 1.obs;
    }
    update();
  }

}