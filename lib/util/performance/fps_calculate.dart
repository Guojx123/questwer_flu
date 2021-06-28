import 'dart:ui';
import 'package:oktoast/oktoast.dart';

//原始FPS回调
var originalCallback;

const maxFrames = 25;
final lastFrames = <FrameTiming>[];
const frameInterval = const Duration(microseconds: Duration.microsecondsPerSecond ~/ 60);

void onReportTimings(List<FrameTiming> timings) {
  lastFrames.addAll(timings);
  if (lastFrames.length > maxFrames) {
    lastFrames.removeRange(0, lastFrames.length - maxFrames);
  }

  if (originalCallback != null) {
    originalCallback(timings);
  }
  if (_isDebug()) showToast("fps : ${fps.round()}");
  print("页面帧率 : ${fps.round()}");
}

_isDebug() {
  return true;
}

double get fps {
  int sum = 0;
  for (FrameTiming timing in lastFrames) {
    int duration = timing.timestampInMicroseconds(FramePhase.rasterFinish) -
        timing.timestampInMicroseconds(FramePhase.buildStart);
    if (duration < frameInterval.inMicroseconds) {
      sum += 1;
    } else {
      int count = (duration / frameInterval.inMicroseconds).ceil();
      sum += count;
    }
  }
  return lastFrames.length / sum * 60;
}
