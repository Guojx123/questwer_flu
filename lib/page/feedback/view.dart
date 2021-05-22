import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:questwer_flu/theme/color.dart';
import 'package:questwer_flu/widget/all_statue_widget.dart';
import 'action.dart';
import 'page.dart';
import 'state.dart';

Widget buildView(
    SubmitFeedbackPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('用户反馈'),
      actions: [
        Container(
          decoration: BoxDecoration(
              color: state.reasonText == ''
                  ? rLightPurpleColor
                  :rDeepPurpleColor,
              borderRadius: BorderRadius.all(Radius.circular(7))
          ),
          margin: EdgeInsets.symmetric(vertical: 6,horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              // 校验数据
              if (state.reasonText != '') {
                dispatch(SubmitFeedbackPageActionCreator.toLoading(true));
                dispatch(SubmitFeedbackPageActionCreator.toSubmit(
                    state.selectType, state.reasonText,
                    pics: state.uploadImageState.imageList ?? [],
                    email: state.emailText));
              } else {

              }
            },
            child: Center(
              child: Text(
                  '提交',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ],
    ),
    body: AllStatuesWidget(
      loading: state.showLoading,
      successChild: GestureDetector(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // type
                Container(
                    child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(20, 12, 20, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '* ',
                            style: TextStyle(
                              height: 1.9,
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '选择反馈类型',
                            style: TextStyle(
                              color: Color(0xFF303133),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: state.typeList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final type = state.typeList[index];
                            return InkWell(
                              onTap: () {
                                dispatch(
                                    SubmitFeedbackPageActionCreator.selectType(
                                        type));
                              },
                              child: Container(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Image.asset(
                                          (type == state.selectType)
                                              ? 'assets/radio_checked.png'
                                              : 'assets/radio_uncheck.png',
                                          width: 35,
                                          fit: BoxFit.fitWidth),
                                    ),
                                    Expanded(
                                        child: Container(
                                            child: Text(
                                      type,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF666666)),
                                    ))),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                )),
                // reason
                Container(
                  width: double.infinity,
                  height: 152,
                  margin:
                      EdgeInsets.only(top: 6, left: 16, right: 16, bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xFFF6F5F7),
                  ),
                  child: TextField(
                    maxLines: 5,
                    maxLength: 200,
                    onChanged: (value) {
                      dispatch(
                          SubmitFeedbackPageActionCreator.setReasonText(value));
                    },

                    decoration: InputDecoration(

                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      hintText: '',
                      hintStyle: TextStyle(
                          fontSize: 12, color: Color(0xFFC6C6C6)),
                      counterStyle: TextStyle(
                          fontSize: 12, color: Color(0xFFC6C6C6)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    cursorColor: Color(0xFFC6C6C6),
                    cursorWidth: 1.5,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 12, color: ColorsTheme.grey),
                  ),
                ),
                // upload image
                Container(
                  child: viewService.buildComponent('uploadImageComponent'),
                ),
                // enter email
                Container(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(20, 18, 20, 10),
                        child: Text(
                          "你的邮箱 (选填) ",
                          style: TextStyle(
                              color: Color(0xFF303133),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 48,
                        margin: EdgeInsets.only(
                            top: 10, left: 20, right: 20, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFFF6F5F7),
                        ),
                        child: TextField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            hintText: '输入邮箱',
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFC6C6C6)),
                            counterStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFC6C6C6)),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onChanged: (value) {
                            dispatch(
                                SubmitFeedbackPageActionCreator.setEmailText(
                                    value));
                          },
                          cursorColor: Color(0xFFC6C6C6),
                          cursorWidth: 1.5,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 12,
                              color: ColorsTheme.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
