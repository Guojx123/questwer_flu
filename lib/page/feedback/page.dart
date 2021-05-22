import 'package:fish_redux/fish_redux.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'upload_image/component.dart';
import 'view.dart';

class SubmitFeedbackPage
    extends Page<SubmitFeedbackPageState, Map<String, dynamic>> {
  static const String NAME = 'submit_feedback';

  SubmitFeedbackPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SubmitFeedbackPageState>(
              adapter: null,
              slots: <String, Dependent<SubmitFeedbackPageState>>{
                'uploadImageComponent': UploadImageConnector() + UploadImageComponent(),
              }),
          middleware: <Middleware<SubmitFeedbackPageState>>[],
        );
}
