import 'package:flutter/foundation.dart';

class BaseModel<T> with ChangeNotifier {

  T _state;
  T get state => _state;

  BaseModel(this._state);

  void setState(T viewState) {
    _state = viewState;
    notifyListeners();
  }
}