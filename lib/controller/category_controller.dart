import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:questwer_flu/http/ApiService.dart';

class CategoryController extends GetxController{

  var isLoading = true.obs;
  var categoryList = List<LCObject>().obs;
  RefreshController refreshController;

  @override
  void onInit() {
    fetchCategoryList();
    refreshController = new RefreshController();
    super.onInit();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  fetchCategoryList() async {
    try {
      isLoading(true);
      List<LCObject> list = await ApiService.fetchCategoryList();
      if (list != null) {
        categoryList.assignAll(list);
        debugPrint("获取分类列表数据");
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
    update();
  }

}