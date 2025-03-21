// 事件总线方法
class EventBus {
  EventBus._internal();

  static EventBus? _instance;
  static EventBus? get instance => getInstance();

  static EventBus? getInstance() {
    _instance ??= EventBus._internal();
    return _instance;
  }

  final Map<String, Function> _events = {};

  void addEventListener(String eventName, Function eventCallback) {
    if (!_events.containsKey(eventName)) {
      _events[eventName] = eventCallback;
    }
  }

  void removeEventListener(String eventName) {
    if (_events.containsKey(eventName)) {
      _events.remove(eventName);
    }
  }

  void triggerEvent(String eventName, [dynamic data]) {
    if (_events.containsKey(eventName)) {
      _events[eventName]!(data);
    }
  }
}

class EventBusType {
  static const String unAuthorized = "unauthorized";
  static const String forbidden = 'forbidden';
  static const String logout = 'logout';
}
