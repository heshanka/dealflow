
import 'dart:async';

import 'package:dealflow_coding_assignment/conveyors/conveyor.dart';
import 'package:dealflow_coding_assignment/conveyors/login_conveyor.dart';
import 'package:dealflow_coding_assignment/models/login_auth.dart';
import 'package:flutter/foundation.dart';

class LoginController with ChangeNotifier {
  bool _isSuccess = false;
  bool _isLoading = false;
  bool showPassword = false;
  static bool isUserLoggedIn = false;
  bool get isSuccess => _isSuccess;

  bool get isLoading => _isLoading;

  bool isEmail(String str) {
    if (str == null || str.trim().isEmpty) return false;
    RegExp emailRegex = RegExp(
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

    return emailRegex.hasMatch(str.trim().toLowerCase());
  }

  Future loginRequest(username, password, remember) async {
    _isLoading = true;
    notifyListeners();

    LoginAuth? _loginAuth = await LoginConveyor.getInstance().login(username, password);
    await Conveyor.secureStorage.write(key: "accessToken", value: _loginAuth?.accessToken);

    if (_loginAuth != null) {
      _isSuccess = true;
      isUserLoggedIn = true;
      _isLoading = false;

      notifyListeners();
    } else {
      _isSuccess = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateShowPassword({bool value = false}) {
    showPassword = value;
    notifyListeners();
  }
}
