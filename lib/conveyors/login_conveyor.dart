
import 'dart:convert';
import 'package:dealflow_coding_assignment/models/login_auth.dart';
import 'package:http/http.dart';

import 'conveyor.dart';

class LoginConveyor extends Conveyor{

static LoginConveyor? instance;

static LoginConveyor getInstance() {
return instance ?? LoginConveyor();
}

Future<LoginAuth?> login(String username, String password) async {
  String _username = username;
  Response responseAuth = await sendPost(
    headers: await Conveyor.getAuthHeader(),
      endpointPath: 'login',
        requestBody: json.encode({
          'grant_type': 'password',
          'username': _username,
          'password': password,
        }));

  if (responseAuth.statusCode < 400) {
    return  LoginAuth.fromJson(jsonDecode(responseAuth.body));
  }
  return null;
}

  @override
  String? getBlueprintName() => null;

  @override
  createObject(Map<String, dynamic>? input) => null;
}