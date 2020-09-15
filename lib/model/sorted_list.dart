import 'package:flutter/foundation.dart';


class SortedList extends ChangeNotifier {
  List<int> _list = new List();

  String get list => _list.join(', ');

  int get length => _list.length;

  void addItem(String item) {

    item.split(',').forEach((element) {
      _list.add(int.parse(element.trim()));
    });
    _list.sort();

    notifyListeners();
  }
}