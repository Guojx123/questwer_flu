import 'package:fish_redux/fish_redux.dart';
import 'upload_image/state.dart';

class SubmitFeedbackPageState implements Cloneable<SubmitFeedbackPageState> {
  String selectType;
  List<String> typeList;
  String reasonText;
  String emailText;
  bool showLoading = true; //是否显示加载拦截

  UploadImageState uploadImageState;

  @override
  SubmitFeedbackPageState clone() {
    return SubmitFeedbackPageState()
      ..uploadImageState = uploadImageState
      ..selectType = selectType
      ..typeList = typeList
      ..reasonText = reasonText
      ..emailText = emailText
      ..showLoading = showLoading;
  }
}

SubmitFeedbackPageState initState(Map<String, dynamic> args) {
  return SubmitFeedbackPageState()..uploadImageState = UploadImageState();
}

class UploadImageConnector
    extends ConnOp<SubmitFeedbackPageState, UploadImageState> {
  @override
  UploadImageState get(SubmitFeedbackPageState state) {
    return state.uploadImageState;
  }

  @override
  void set(SubmitFeedbackPageState state, UploadImageState subState) {
    state.uploadImageState = subState;
  }
}
