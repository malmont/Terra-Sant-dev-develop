import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/favorite_list_models.dart';

class FavoritePageModel extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  late FavoriteListModel favorite_list;

  final List<int> _itemIds = [];

  FavoriteListModel get favoriteList => favorite_list;

  set favoritelist(FavoriteListModel newList) {
    favorite_list = newList;
    notifyListeners();
  }

  List<Item> get items =>
      _itemIds.map((id) => favorite_list.getById(id)).toList();

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}
