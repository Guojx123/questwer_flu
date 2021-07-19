import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';

class UserController extends GetxController {
  var isAuth = false.obs;

  @override
  void onInit() {
    isAuthenticated();

    super.onInit();
  }

  isAuthenticated() async {
    LCUser currentUser = await LCUser.getCurrent();
    if (currentUser != null) {
      // 跳到首页
      isAuth = false.obs;
    } else {
      // 显示注册、登录或欢迎页面
      isAuth = true.obs;
    }
    update();
  }
}
