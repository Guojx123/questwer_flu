import 'package:fish_redux/fish_redux.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UploadImageState implements Cloneable<UploadImageState> {
  List<AssetEntity> imageList;

  @override
  UploadImageState clone() {
    return UploadImageState()
      ..imageList = imageList
    ;
  }
}

UploadImageState initState(Map<String, dynamic> args) {
  return UploadImageState()
    ..imageList = [];
}
