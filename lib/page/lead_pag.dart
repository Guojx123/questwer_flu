import 'package:flutter/material.dart';
import 'package:questwer_flu/util/shared_preferences.dart';
import 'package:questwer_flu/widget/common_app_bar.dart';

class LeadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          CommonAppBar("hi,${PersistentStorage.get("nickname")}",canBack: false,),
          Expanded(
              child: Container()
          ),
        ],
      ),
    );
  }
}
