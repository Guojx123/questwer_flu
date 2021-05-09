import 'package:get_it/get_it.dart';
import 'service_tel_and_sms.dart';

GetIt locator = GetIt();

void setupLocator() {

  locator.registerSingleton(TelAndSmsService());
}