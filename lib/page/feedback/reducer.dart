import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SubmitFeedbackPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SubmitFeedbackPageState>>{
      SubmitFeedbackPageAction.onSetType: _onSetType,
      SubmitFeedbackPageAction.onSetReasonText: _onSetReasonText,
      SubmitFeedbackPageAction.onSetEmailText: _onSetEmailText,
      SubmitFeedbackPageAction.onLoading: _onLoading,
      SubmitFeedbackPageAction.onSubmit: _onSubmit
    },
  );
}

SubmitFeedbackPageState _onSetType(
    SubmitFeedbackPageState state, Action action) {
  final newState = state.clone();
  return newState;
}

SubmitFeedbackPageState _onSetReasonText(
    SubmitFeedbackPageState state, Action action) {
  final newState = state.clone();
  return newState;
}

SubmitFeedbackPageState _onSetEmailText(
    SubmitFeedbackPageState state, Action action) {
  final newState = state.clone();
  return newState;
}

SubmitFeedbackPageState _onLoading(
    SubmitFeedbackPageState state, Action action) {
  final newState = state.clone();
  return newState;
}

SubmitFeedbackPageState _onSubmit(
    SubmitFeedbackPageState state, Action action) {
  final newState = state.clone();
  return newState;
}
