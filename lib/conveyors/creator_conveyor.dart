import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../conveyor.dart';
import '../models/creator.dart';

class CreatorConveyor extends Conveyor<Creator>{

  static CreatorConveyor? instance;

  static CreatorConveyor? getInstance() {
    return instance ?? CreatorConveyor();
  }

  @override
  Creator createObject(Map<String, dynamic>? input) {
    return Creator.fromJson(input!);
  }

  @override
  String getBlueprintName() {
    return ("users");
  }

  Future<List<Creator>?> getCreatorList({Map<String, String>? headers, int? id} ) async {
    Response? response = await sendGet();
    print("RESPONSE $response");
    List<Creator> returnList = [];
    for (var item in json.decode(response!.body)) {
      returnList.add(Creator.fromJson(item as Map<String, dynamic>));
    }
    return response != null && response.statusCode == 200
        ? returnList
        : null;
  }

  Future<List<Creator>?> filterCreatorList(String filterTerm) async {
    Response? response = await sendGet(params: {"filter": filterTerm});
    List<Creator> returnList = [];
    for (var item in json.decode(response!.body)) {
      returnList.add(Creator.fromJson(item as Map<String, dynamic>));
    }
    return response != null && response.statusCode == 200
        ? returnList
        : null;
  }
}