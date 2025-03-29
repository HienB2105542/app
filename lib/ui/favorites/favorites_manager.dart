import 'package:flutter/material.dart';
import '../../models/homestay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesManager extends ChangeNotifier {
  final Set<Homestay> _favoriteHomestays = {};

  FavoritesManager() {
    _loadFavorites();
  }

  List<Homestay> get favoriteHomestays => _favoriteHomestays.toList();

  void toggleFavorite(Homestay homestay) async {
    Homestay updatedHomestay =
        homestay.copyWith(isFavorite: !_favoriteHomestays.contains(homestay));

_favoriteHomestays.removeWhere((h) => h.id == homestay.id);
    _favoriteHomestays.add(updatedHomestay);

    await _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Homestay homestay) {
    return _favoriteHomestays.any((h) => h.id == homestay.id);
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> homestayList =
        _favoriteHomestays.map((h) => jsonEncode(h.toJson())).toList();
    await prefs.setStringList('favoriteHomestays', homestayList);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? storedFavorites = prefs.getStringList('favoriteHomestays');

    if (storedFavorites != null) {
      _favoriteHomestays.clear(); 
      _favoriteHomestays.addAll(
        storedFavorites.map((e) => Homestay.fromJson(jsonDecode(e))),
      );
    }
    notifyListeners();
  }
}
