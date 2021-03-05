import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/http/ApiService.dart';

class CategoryController extends GetxController{

  var isLoading = true.obs;
  var categoryList = List<LCObject>().obs;

  @override
  void onInit() {
    fetchCategoryList();
    super.onInit();
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