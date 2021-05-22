import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class UploadImageComponent extends Component<UploadImageState> {
  UploadImageComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<UploadImageState>(
              adapter: null, slots: <String, Dependent<UploadImageState>>{}),
        );
}
