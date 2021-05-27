import 'package:fish_redux/fish_redux.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class UploadImageState implements Cloneable<UploadImageState> {
  List<Asset> imageList;

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
