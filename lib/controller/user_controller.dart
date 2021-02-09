import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/util/shared_preferences.dart';

class UserController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  isAuthenticated() async {
    LCUser currentUser = await LCUser.getCurrent();
    bool isAuthenticated = await currentUser.isAuthenticated();
    PersistentStorage().setStorage("isAuth", isAuthenticated);
  }

}