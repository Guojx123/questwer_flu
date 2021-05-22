import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action, Page;
import 'package:questwer_flu/theme/color.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
  /// [Gino] WeChat assets picker
  final maxAssetsCount = 10;
  final pageSize = 32;
  var resultList = <AssetEntity>[];

  try {
    resultList = await AssetPicker.pickAssets(ctx.context,
        pageSize: pageSize,
        maxAssets: maxAssetsCount,
        themeColor: rBlueColor,
        previewThumbSize: <int>[360, 360],
        selectedAssets: ctx.state.imageList,
        requestType: RequestType.image,
        textDelegate: TextDelegate(
          confirm: '确定',
          cancel: '取消',
          edit: '编辑',
          gifIndicator: 'GIF',
          heicNotSupported: 'heic 类型不支持',
          loadFailed: '加载失败',
          original: '原图',
          preview: '预览',
          select: '选择',
          unSupportedAssetType: '不支持该类型',
          emptyPlaceHolder: '空'
        ));
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
      .removeWhere((element) => element.title == payload['deleteImageName']);
  ctx.dispatch(UploadImageActionCreator.onDeletePictures());
}

class TextDelegate implements AssetsPickerTextDelegate {
  @override
  String confirm;

  @override
  String cancel;

  @override
  String edit;

  @override
  String gifIndicator;

  @override
  String heicNotSupported;

  @override
  String loadFailed;

  @override
  String original;

  @override
  String preview;

  @override
  String select;

  @override
  String unSupportedAssetType;

  @override
  String emptyPlaceHolder;

  TextDelegate(
      {this.confirm,
      this.cancel,
      this.edit,
      this.gifIndicator,
      this.heicNotSupported,
      this.loadFailed,
      this.original,
      this.preview,
      this.select,
      this.unSupportedAssetType,
      this.emptyPlaceHolder});

  @override
  String durationIndicatorBuilder(Duration duration) {
    const String separator = ':';
    final String minute = duration.inMinutes.toString().padLeft(2, '0');
    final String second =
    ((duration - Duration(minutes: duration.inMinutes)).inSeconds)
        .toString()
        .padLeft(2, '0');
    return '$minute$separator$second';
  }

}
