import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:questwer_flu/http/ApiService.dart';

class LeadController extends GetxController{

  var isLoading = true.obs;
  var activityList = List<LCObject>().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getActivity() async {
    try {
      isLoading(true);
      List<LCObject> activityItem = await ApiService.fetchActivityList();
      if (activityItem != null) {
        activityList.assignAll(activityItem);
        debugPrint("获取活动数据");
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
    update();
  }
}
