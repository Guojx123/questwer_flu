import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// @author [zoro]
/// 【加载页面】
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
