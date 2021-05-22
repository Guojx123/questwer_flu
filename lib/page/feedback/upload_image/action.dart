import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum UploadImageAction {
  addPictures,
  onAddPictures,
  deletePicture,
  onDeletePictures
}

class UploadImageActionCreator {


  static Action addPictures() {
    return Action(UploadImageAction.addPictures);
  }

  static Action onAddPictures() {
    return Action(UploadImageAction.onAddPictures);
  }

  static Action deletePictures(String name) {
    return Action(UploadImageAction.deletePicture,
        payload: {'deleteImageName': name});
  }

  static Action onDeletePictures() {
    return Action(UploadImageAction.onDeletePictures);
  }
}
