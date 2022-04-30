import 'package:flutter/cupertino.dart';

class CurrentData with ChangeNotifier {
  String? _currentCode;
  String? _flagUrl;

  CurrentData([this._currentCode, this._flagUrl]);

  String get currentCode {
    return _currentCode!;
  }

  String get flagUrl {
    return _flagUrl!;
  }

  void setCurrentCode(String code, String url) {
    _currentCode = code;
    _flagUrl = url;
    notifyListeners();
  }
}
