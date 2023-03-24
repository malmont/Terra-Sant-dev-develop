import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/items_model.dart';

class BookmarkBloc extends ChangeNotifier {
  int _count = 0;
  List<ItemModel> items = [];

  void addCount() {
    _count++;
    notifyListeners();
  }

  void addItems(ItemModel data) {
    items.add(data);
    notifyListeners();
  }

  void removeCount() {
    _count--;
    notifyListeners();
  }

  void removeItems(int id) {
    int index = items.indexWhere((element) => element.id == id);
    // ignore: avoid_print
    print(items.removeAt(index));
    notifyListeners();
  }

  int get count {
    return _count;
  }
}
