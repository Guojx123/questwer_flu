import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<UploadImageState> buildReducer() {
  return asReducer(
    <Object, Reducer<UploadImageState>>{
      UploadImageAction.onAddPictures: _onAddPictures,
      UploadImageAction.onDeletePictures: _onDeletePictures,
    },
  );
}

UploadImageState _onAddPictures(UploadImageState state, Action action) {
  final newState = state.clone();
  return newState;
}

UploadImageState _onDeletePictures(UploadImageState state, Action action) {
  final newState = state.clone();
  return newState;
}
