import 'dart:math';
import 'package:flutter/material.dart';
import 'package:questwer_flu/theme/color.dart';

class CustomTab extends StatefulWidget {
  final Widget leftWidget;
  final Widget rightWidget;

  CustomTab({Key key, @required this.leftWidget, @required this.rightWidget})
      : super(key: key);

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> with TickerProviderStateMixin {
  PageController pageController;
  PageView pageView;
  int currentPage = 0;
  Color left = rBlueColor;
  Color right = rTextWhiteColor;

  Widget get leftWidget => widget.leftWidget;

  Widget get rightWidget => widget.rightWidget;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageView = PageView(
      controller: pageController,
      children: <Widget>[
        leftWidget,
        rightWidget,
      ],
      onPageChanged: (index) {
        setState(() {
          if (index == 0) {
            right = rTextWhiteColor;
            left = rBlueColor;
          } else if (index == 1) {
            right = rBlueColor;
            left = rTextWhiteColor;
          }
          currentPage = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Container(
                width: 300.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color(0x552B2B2B),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: CustomPaint(
                  painter: TabIndicationPainter(pageController: pageController),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: null,
                          child: Text(
                            'Multiple-Choice',
                            style: TextStyle(color: left, fontSize: 16.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: null,
                          child: Text(
                            'True-False',
                            style: TextStyle(color: right, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: pageView),
          ],
        ),
      ),
    );
  }
}

class TabIndicationPainter extends CustomPainter {
  Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  final PageController pageController;

  TabIndicationPainter(
      {this.dxTarget = 125.0,
      this.dxEntry = 25.0,
      this.radius = 21.0,
      this.dy = 25.0,
      this.pageController})
      : super(repaint: pageController) {
    painter = Paint()
      ..color = rTextWhiteColor
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController.position;
    double fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);

    double pageOffset = pos.extentBefore / fullExtent;

    bool left2right = dxEntry < dxTarget;
    Offset entry = Offset(left2right ? dxEntry : dxTarget, dy);
    Offset target = Offset(left2right ? dxTarget : dxEntry, dy);

    Path path = Path();
    path.addArc(
        Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(
        Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);
    canvas.drawShadow(path, rBlueColor, 3.0, true);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}
