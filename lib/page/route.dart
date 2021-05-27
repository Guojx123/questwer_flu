import 'package:flutter/material.dart';
import 'package:questwer_flu/page/welcome/welcome_page.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      Welcome.NAME: (_) => Welcome(),
    };
  }
}
