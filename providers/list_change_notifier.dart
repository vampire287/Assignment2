import 'package:flutter/material.dart';

class ListNotifier extends ChangeNotifier {
  String name;
  ListNotifier({this.name = '....'});
  List<String> selections = <String>[];
  // List<String> get selections => selections;

  void addString(String value) {
    selections.add(value);
    notifyListeners();
  }

  void removeString(String value) {
    selections.remove(value);
    notifyListeners();
  }

  void updateList(List<String> value) {
    for (var i in value) {
      selections.add(i);
    }
    notifyListeners();
  }
}
