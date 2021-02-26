///Function: 日志打印
///
///实现：
///打印到控制台
///打印长文本
///
///待完善：
///日志分类保存，可上传
///
///@author xucz
///@since 2020/10/26

class LogService {
  static const String _defTag = 'log_service';

  bool _debugMode = false; //是否是debug模式,true: log v 不输出.
  int _maxLen = 200;
  String _tagValue = _defTag;

  LogService({
    String tag = _defTag,
    bool isDebug = false,
    int maxLen = 60,
  }) {
    _tagValue = tag;
    _debugMode = isDebug;
    _maxLen = maxLen;
  }

  void e(Object object, {String tag}) {
    _printLog(tag, ' e ', object);
  }

  void v(Object object, {String tag}) {
    if (_debugMode) {
      _printLog(tag, ' v ', object);
    }
  }

  void _printLog(String tag, String stag, Object object) {
    String da = object.toString();
    tag = tag ?? _tagValue;
    if (da.length <= _maxLen) {
      print('$tag$stag $da');
      return;
    }
    print(
        '$tag$stag — — — — — — — — — — — — — — — — st — — — — — — — — — — — — — — — —');
    while (da.isNotEmpty) {
      if (da.length > _maxLen) {
        print('$tag$stag| ${da.substring(0, _maxLen)}');
        da = da.substring(_maxLen, da.length);
      } else {
        print('$tag$stag| $da');
        da = '';
      }
    }
    print(
        '$tag$stag — — — — — — — — — — — — — — — — ed — — — — — — — — — — — — — — — —');
  }
}
