import 'package:fish_redux/fish_redux.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

//TODO replace with your own action
enum SubmitFeedbackPageAction {
  selectType,
  onSetType,
  setReasonText,
  onSetReasonText,
  setEmailText,
  onSetEmailText,
  toLoading,
  onLoading,
  toSubmit,
  onSubmit,
}

class SubmitFeedbackPageActionCreator {

  static Action selectType(String type) {
    return Action(SubmitFeedbackPageAction.selectType, payload: {'type': type});
  }

  static Action onSetType() {
    return const Action(SubmitFeedbackPageAction.onSetType);
  }

  static Action setReasonText(String text) {
    return Action(SubmitFeedbackPageAction.setReasonText,
        payload: {'text': text});
  }

  static Action onSetReasonText() {
    return const Action(SubmitFeedbackPageAction.onSetReasonText);
  }

  static Action setEmailText(String text) {
    return Action(SubmitFeedbackPageAction.setEmailText,
        payload: {'text': text});
  }

  static Action onSetEmailText() {
    return const Action(SubmitFeedbackPageAction.onSetEmailText);
  }

  static Action toLoading(bool isLoading) {
    return Action(SubmitFeedbackPageAction.toLoading,
        payload: {'loading': isLoading});
  }

  static Action onLoading() {
    return Action(SubmitFeedbackPageAction.onLoading);
  }

  static Action toSubmit(String type, String msg,
      {List<AssetEntity> pics, String email}) {
    return Action(SubmitFeedbackPageAction.toSubmit, payload: {
      'type': type,
      'message': msg,
      'pictures': pics,
      'email': email
    });
  }

  static Action onSubmit() {
    return Action(SubmitFeedbackPageAction.toSubmit);
  }
}
