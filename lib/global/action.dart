import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { changeThemeColor, back }

class GlobalActionCreator {
  static Action onchangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }

  static Action back() {
    return const Action(GlobalAction.back);
  }
}
