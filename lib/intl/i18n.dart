import 'package:get/get.dart';

class Messages extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    "en_US":{
      'hi':'Hi',
      //设置
      'setting.follow_system':'Follow system',
      'setting.choose_language':'Choose App language',
      'setting.choose_language_desc':'Set the current locale, effective immediately',
    },
    "zh_CN":{
      'hi':'你好',
      //设置
      'setting.follow_system':'跟随系统',
      'setting.choose_language':'选择语言环境',
      'setting.choose_language_desc':'设置当前语言环境，即刻生效',
    },
  };

}