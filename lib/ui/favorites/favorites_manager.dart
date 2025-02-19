import 'package:flutter/material.dart';
import '../../models/homestay.dart';

class FavoritesManager extends ChangeNotifier {
  final Set<Homestay> _favoriteHomestays = {};

  List<Homestay> get favoriteHomestays => _favoriteHomestays.toList();

  void toggleFavorite(Homestay homestay) {
    if (_favoriteHomestays.contains(homestay)) {
      _favoriteHomestays.remove(homestay);
    } else {
      _favoriteHomestays.add(homestay);
    }
    notifyListeners();
  }

  bool isFavorite(Homestay homestay) {
    return _favoriteHomestays.contains(homestay);
  }
}
