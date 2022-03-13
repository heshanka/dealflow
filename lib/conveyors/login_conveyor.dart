
import 'dart:convert';
import 'conveyor.dart';

class LoginConveyor extends Conveyor{

static LoginConveyor? instance;

static LoginConveyor getInstance() {
return instance ?? LoginConveyor();
}

Future<Future> login(String username, String password) async {
  String _username = username;
  Future<dynamic> responseAuth = sendPost(
      endpointPath: 'login',
        requestBody: json.encode({
          'grant_type': 'password',
          'username': _username,
          'password': password,
        }));
  return responseAuth;
/*  if (responseAuth != null*//* && responseAuth['statuscode'] == 200*//*) {
    return LoginAuth.fromJson(responseAuth as Future<dynamic>);
  }
  return null;*/
}

  @override
  String? getBlueprintName() => null;

  @override
  createObject(Map<String, dynamic>? input) => null;
}