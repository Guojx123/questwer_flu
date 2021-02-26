
import 'log_service.dart';
import 'services_manager.dart';

class Logger {
  static void v(Object object, {String tag}) {
    Services.of<LogService>().v(object, tag: tag);
  }

  static void e(Object object, {String tag}) {
    Services.of<LogService>().e(object, tag: tag);
  }
}
