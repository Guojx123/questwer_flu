import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

import 'action.dart';
import 'state.dart';

Effect<GlobalState> buildEffect() {
  return combineEffects(
      <Object, Effect<GlobalState>>{GlobalAction.back: _back});
}

void _back(Action action, Context<GlobalState> ctx) {
  Navigator.of(ctx.context).pop();
}
