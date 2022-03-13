import 'dart:async';

import 'package:dealflow_coding_assignment/models/creator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../conveyors/creator_conveyor.dart';

class HomeController with ChangeNotifier {

  List<Creator> creatorsList = [];
  bool creatorsListLoaded = false;

  TextEditingController filterController = TextEditingController();
  FocusNode filterNode = FocusNode();

  HomeController(){
     getCreatorsList();
  }

  Future getCreatorsList() async {
    if (!creatorsListLoaded) {
      creatorsList = (await CreatorConveyor.getInstance()?.getCreatorList())!;
      if (creatorsList.isNotEmpty) {
        creatorsList = creatorsList;
        creatorsListLoaded = true;
        notifyListeners();
      }
    }
  }

  Future filterCreatorsList(String filterTerm) async {
    print("aaaaaa");
      creatorsList = (await CreatorConveyor.getInstance()?.filterCreatorList(filterTerm))!;
      if (creatorsList.isNotEmpty) {
        creatorsList = creatorsList;
        creatorsListLoaded = true;
        print("FILTERED");
        print(creatorsList);
        notifyListeners();
      }
  }
}