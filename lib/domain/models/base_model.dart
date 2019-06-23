import 'package:flutter/foundation.dart';

class BaseModel<T> with ChangeNotifier {

  T _state;
  T get state => _state;

  BaseModel(this._state);

  void setState(T viewState) {
    print("setting state: $viewState");
    _state = viewState;
    notifyListeners();
  }

  void setStateQuietly(T viewState) {
    print("setting state quietly: $viewState");
    _state = viewState;
  }
}