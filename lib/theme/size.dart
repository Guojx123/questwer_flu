
import 'package:questwer_flu/util/ui/app_dimensions.dart';

const smallSize = 0.4;
const defaultPadding = 10;

class DefaultSize {
  static double get defaultPadding => AppDimensions.padding * 1.0;

  static double get basePadding => AppDimensions.padding * 0.1;

  static double get smallSize => AppDimensions.padding * 0.5;

  static double get middleSize => AppDimensions.padding * 1.0;

  static double get largeSize => AppDimensions.padding * 5.0;

  static double get fontSize => AppDimensions.ratio * 1.6;

  static double get smallFontSize => AppDimensions.ratio * 1.4;

  static double get middleFontSize => AppDimensions.ratio * 2.0;

  static double get largeFontSize => AppDimensions.ratio * 2.6;
}
