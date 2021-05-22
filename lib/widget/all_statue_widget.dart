import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

///通用状态页面【可以有】【加载】【错误】【成功】【没数据等】
class AllStatuesWidget extends StatelessWidget {
  final Widget successChild;
  final bool loading;
  final bool error;

  const AllStatuesWidget({
    Key key,
    @required this.successChild,
    this.loading = false,
    this.error = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        successChild != null ? successChild : Container(),
        _buildLoadingWidget(),
      ],
    );
  }

  ///加载中的widget
  Widget _buildLoadingWidget() {
    return Offstage(
      offstage: !loading,
      child: Container(
        color: Colors.white.withOpacity(0.5),
        child: LoadingWidget(),
      ),
    );
  }
}
