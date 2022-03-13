
import 'dart:async';
import 'dart:convert';

import 'package:dealflow_coding_assignment/conveyors/creator_conveyor.dart';
import 'package:dealflow_coding_assignment/models/creator.dart';
import 'package:flutter/foundation.dart';

class SignUpController with ChangeNotifier{

    bool showPassword = false;

    Future addNewCreator(String? username, String? password, String? email) async {
        Creator creator = Creator(username: username, email: email);
        await CreatorConveyor.getInstance()?.sendPost(requestBody: jsonEncode(creator.toJson()));
    }

    void updateShowPassword({bool? value}) {
        showPassword = value!;
        notifyListeners();
    }

}