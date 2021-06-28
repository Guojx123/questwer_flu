import 'package:flutter/material.dart';
import 'dart:async';

int totalPV = 0;

class PageException {
  int exceptionCount = 0;

  Future<Null> reportError(dynamic error, dynamic stackTrace) async {
    // 累加异常次数
    exceptionCount++;
  }

  double pageException() {
    if (totalPV == 0) return 0;
    // 输出页面异常率
    return exceptionCount / totalPV;
  }
}

class MyObserver extends NavigatorObserver {

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('${route.navigator.widget}');
  }

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    totalPV++; //累加PV
  }
}
