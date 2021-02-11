import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:questwer_flu/theme/color.dart';

class RefreshFooter extends StatelessWidget {
  final Color bgColor;

  RefreshFooter({
    Key key,
    this.bgColor = Colors.teal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      idleText: "",
      loadingIcon: CupertinoActivityIndicator(),
      canLoadingText: "",
      failedText: "fail",
      noDataText: "no data",
      loadingText: "loading",
      outerBuilder: (child) {
        return Container(
          height: 60,
          alignment: Alignment.center,
          color: bgColor,
          child: child,
        );
      },
    );
  }
}
