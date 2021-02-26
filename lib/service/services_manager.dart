import 'dart:collection';

typedef S ServiceCreator<S>();

class Services {
  static Map<String, Object> servicesMap = HashMap();

  static Map<String, ServiceCreator<Object>> defaultCreatorMap = {};

  static T of<T>({
    ServiceCreator<T> creator,
  }) {
    String key = T.toString();
    Object value = servicesMap[key];

    if (value == null && creator == null && defaultCreatorMap[key] != null) {
      creator = defaultCreatorMap[key];
    }

    if (value == null && creator != null) {
      value = creator();
      servicesMap[key] = value;
    }

    return value;
  }
}
