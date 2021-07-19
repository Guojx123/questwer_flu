import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:questwer_flu/http/ApiService.dart';
import 'package:questwer_flu/model/question_bank.dart';
import 'package:questwer_flu/service/getx_snack_bar.dart';

import 'question_list_controller.dart';

class PopMenuController extends GetxController {
  PopupMenu menu;

  ScrollController scrollController;

  QuestionBank questionBankItem;

  final QuestionListController _questionListController =
      Get.put(QuestionListController());

  @override
  void onInit() {
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
    questionBankItem = QuestionBank();
    scrollController = ScrollController(keepScrollOffset: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
    if (item.menuTitle == 'Delete') {
      ApiService.deleteQuestionBankByObjectId(questionBankItem.objectId);
      Future.delayed(Duration(milliseconds: 1000))
          .then((value) => _questionListController.refreshList(questionBankItem.owner));
    }else if(item.menuTitle == 'Share'){
      GetXSnackBar().toShareById(questionBankItem.toShareId);
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }
}
