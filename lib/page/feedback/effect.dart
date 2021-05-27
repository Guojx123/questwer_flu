import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:get_storage/get_storage.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:oktoast/oktoast.dart';
import 'package:questwer_flu/http/feedback.dart';
import 'package:questwer_flu/http/upload.dart';
import 'package:questwer_flu/theme/color.dart';
import 'action.dart';
import 'state.dart';

Effect<SubmitFeedbackPageState> buildEffect() {
  return combineEffects(<Object, Effect<SubmitFeedbackPageState>>{
    Lifecycle.initState: _initState,
    SubmitFeedbackPageAction.selectType: _setType,
    SubmitFeedbackPageAction.setReasonText: _setReasonText,
    SubmitFeedbackPageAction.setEmailText: _setEmailText,
    SubmitFeedbackPageAction.toLoading: _toLoading,
    SubmitFeedbackPageAction.toSubmit: _toSubmit,
  });
}

void _initState(Action action, Context<SubmitFeedbackPageState> ctx) {
  var typeList = "[\"芒果\",\"快递\",\"蛋花\",\"南方佬困困\"]";
  var list = List<String>.from(jsonDecode(typeList));
  ctx.state.typeList = list;
  ctx.state.selectType = list.first;
  ctx.state.reasonText = '';
  ctx.state.showLoading = false;
}

void _setType(Action action, Context<SubmitFeedbackPageState> ctx) {
  dynamic payload = action.payload;
  ctx.state.selectType = payload['type'];
  ctx.dispatch(SubmitFeedbackPageActionCreator.onSetType());
}

void _setReasonText(Action action, Context<SubmitFeedbackPageState> ctx) {
  dynamic payload = action.payload;
  ctx.state.reasonText = payload['text'];
  ctx.dispatch(SubmitFeedbackPageActionCreator.onSetReasonText());
}

void _setEmailText(Action action, Context<SubmitFeedbackPageState> ctx) {
  dynamic payload = action.payload;
  ctx.state.emailText = payload['text'];
  ctx.dispatch(SubmitFeedbackPageActionCreator.onSetEmailText());
}

void _toLoading(Action action, Context<SubmitFeedbackPageState> ctx) {
  dynamic payload = action.payload;
  ctx.state.showLoading = payload['loading'];
  ctx.dispatch(SubmitFeedbackPageActionCreator.onLoading());
}

void _toSubmit(Action action, Context<SubmitFeedbackPageState> ctx) async {
  dynamic payload = action.payload;
  var imgList = <String>[];

  /// a.上传图片
  if (payload['pictures'] != null && payload['pictures'] != []) {
    List<Asset> pictures = payload['pictures'];

    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    for (var i = 0; i < pictures.length; i++) {
      var byteData = await pictures[i].getByteData(quality: 65);

      final buffer = byteData.buffer;

      var rand = Random().nextInt(100000);
      final tempImgPath = '$tempPath/img_$rand.jpg';
      var compressImg = await File(tempImgPath).writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      var imgLink = await UploadProvider().uploadImage(compressImg);
      imgList.add(imgLink);
    }

  }

  /// b.接口提交反馈原因、描述、邮箱
  var apiResponse = await FeedBack().sendFeedBack(
    ctx.context,
    payload['type'],
    payload['message'],
    pics: imgList,
    email: payload['email'],
  );

  if (apiResponse.code == 0) {
    ctx.dispatch(SubmitFeedbackPageActionCreator.toLoading(false));

    await showGeneralDialog(
        context: ctx.context,
        barrierDismissible: false,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SafeArea(child: Builder(
            builder: (context) {
              return Material(
                color: Colors.black.withOpacity(0.4),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      padding: EdgeInsets.only(
                          top: 10,
                          bottom: 30,
                          left: 10,
                          right: 10),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                    'assets/feedback_success_icon.png',
                                    width: 48))),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                            width: 260,
                            child: Text(
                                '感谢你的反馈',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF303133),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                            width: 270,
                            child: Text(
                                '你的反馈让App变得更好',
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 15))),
                        SizedBox(
                          height: 32,
                        ),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10),
                            width: 260,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorsTheme.purple,
                            ),
                            child: Text(
                                '确认',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ])),
                ),
              );
            },
          ));
        });
  } else {
    showToast("error",position: ToastPosition.bottom);
    return;
  }
}
