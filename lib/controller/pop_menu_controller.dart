import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:questwer_flu/http/ApiService.dart';

import 'question_list_controller.dart';

class PopMenuController extends GetxController {
  PopupMenu menu;

  ScrollController scrollController;

  String objectId;
  String owner;

  final QuestionListController _questionListController =
      Get.put(QuestionListController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    menu = PopupMenu(items: [
      // MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
      // MenuItem(
      //     title: 'Copy',
      //     image: Icon(
      //       Icons.copy,
      //       color: Colors.white,
      //     )),
      MenuItem(
          title: 'Delete',
          image: Icon(
            Icons.delete,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Share',
          image: Icon(
            Icons.share,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Partook',
          image: Icon(
            Icons.wifi_tethering_sharp,
            color: Colors.white,
          )),
    ], onClickMenu: onClickMenu, onDismiss: onDismiss, maxColumn: 4);
    objectId = '';
    owner = '';
    scrollController = ScrollController(keepScrollOffset: true);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    scrollController.dispose();
    super.onClose();
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
    if (item.menuTitle == 'Delete') {
      ApiService.deleteQuestionBankByObjectId(objectId);
      Future.delayed(Duration(milliseconds: 1000))
          .then((value) => _questionListController.refreshList(owner));
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }
}
