import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:questwer_flu/page/empty_page.dart';
import 'package:questwer_flu/page/welcome_page.dart';

class PopMenuController extends GetxController {
  PopupMenu menu;

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
          title: 'Setting',
          image: Icon(
            Icons.settings,
            color: Colors.white,
          )),
    ], onClickMenu: onClickMenu, onDismiss: onDismiss, maxColumn: 4);
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
}
