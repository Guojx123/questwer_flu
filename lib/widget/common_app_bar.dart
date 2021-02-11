import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool canBack;
  Widget actionWidget;
  Function actionFunction;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(44),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (canBack)
              Positioned(
                left: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  behavior: HitTestBehavior.translucent,
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            Text(
              title ?? '',
              style: TextStyle(fontSize: 21, color: ColorsTheme.black),
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: actionFunction ?? () {},
                behavior: HitTestBehavior.translucent,
                child: actionWidget ?? Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(44);

  CommonAppBar(this.title,
      {this.canBack = true, this.actionWidget, this.actionFunction});
}
