import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action, Page;
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:questwer_flu/theme/color.dart';

import 'action.dart';

import 'state.dart';

Effect<UploadImageState> buildEffect() {
  return combineEffects(<Object, Effect<UploadImageState>>{
    Lifecycle.initState: _initState,
    UploadImageAction.addPictures: _addPictures,
    UploadImageAction.deletePicture: _deletePicture,
  });
}

void _initState(Action action, Context<UploadImageState> ctx) {
  ctx.state.imageList = [];
}

void _addPictures(Action action, Context<UploadImageState> ctx) async {
  /// [Gino] assets picker
  var resultList = <Asset>[];
  var themeColor = '#8287E2';
  try {
    resultList = await MultiImagePicker.pickImages(
      maxImages: 10,
      enableCamera: false,
      selectedAssets: ctx.state.imageList,
      cupertinoOptions: CupertinoOptions(
        takePhotoIcon: 'chat',
      ),
      materialOptions: MaterialOptions(
        actionBarColor: themeColor,
        actionBarTitle: '选择图片',
        statusBarColor: themeColor,
        allViewTitle: '所有图片',
        useDetailsView: false,
        selectCircleStrokeColor: themeColor,
      ),
    );
    if (resultList.isNotEmpty) {
      ctx.state.imageList = resultList;
    }
    ctx.dispatch(UploadImageActionCreator.onAddPictures());
  } on Exception catch (e) {
    debugPrint('Gino error -> $e');
  }
}

void _deletePicture(Action action, Context<UploadImageState> ctx) {
  dynamic payload = action.payload;
  ctx.state.imageList
      .removeWhere((element) => element.name == payload['deleteImageName']);
  ctx.dispatch(UploadImageActionCreator.onDeletePictures());
}
