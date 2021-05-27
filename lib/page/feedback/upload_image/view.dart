import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    UploadImageState state, Dispatch dispatch, ViewService viewService) {
  var screenWidth = MediaQuery.of(viewService.context).size.width;
  var itemWidth = (screenWidth - 20) / 5;

  var imageListWidget = <Widget>[];

  for (var i = 0; i < state.imageList.length; i++) {
    Widget imageItem = Container(
      width: itemWidth,
      height: itemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AssetThumb(
                asset: state.imageList[i],
                width: 360,
                height: 360,
              )),
          Positioned(
              top: 0.0,
              right: 0.0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusScope.of(viewService.context).requestFocus(FocusNode());
                  dispatch(UploadImageActionCreator.deletePictures(
                      state.imageList[i].name));
                },
                child: Image.asset(
                  'assets/icon_feedback_delete.png',
                  width: 16,
                  height: 16,
                ),
              )),
        ],
      ),
    );
    imageListWidget.add(imageItem);
  }

  Widget addWidget = Container(
      width: itemWidth,
      height: itemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(viewService.context).requestFocus(FocusNode());
          dispatch(UploadImageActionCreator.addPictures());
        },
        child: Container(
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFF6F5F7),
            ),
            child: Image.asset(
              'assets/icon_feedback_add.png',
              width: 16,
              height: 16,
            )),
      ));

  if (state.imageList.length < 10) {
    imageListWidget.add(addWidget);
  }
  return Container(
    width: screenWidth,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Wrap(
      alignment: WrapAlignment.start,
      children: imageListWidget,
    ),
  );
}
