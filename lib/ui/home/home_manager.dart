import 'package:flutter/material.dart';
import '../../services/home_service.dart';
import '../../models/homestay.dart';

class HomeManager with ChangeNotifier {
  final HomeService _homeService = HomeService();
  List<Homestay> _homestays = [];

  int get itemCount {
    return _homestays.length;
  }

  List<Homestay> get homestays => _homestays;

  List<Homestay> get favoritehomestays {
    return _homestays.where((homestays) => homestays.isFavorite).toList();
  }

  Homestay? findById(String id) {
    try {
      return _homestays.firstWhere((homestays) => homestays.id == id);
    } catch (errer) {
      return null;
    }
  }

  Future<void> fetchHomestays() async {
    try {
      List<Homestay>? fetchedHomestays = await _homeService.getHomestays();

      _homestays = fetchedHomestays;

      for (var homestay in _homestays) {
        print("Homestay: ${homestay.toJson()}");
      }

      notifyListeners();
    } catch (error) {
      print("Lỗi khi lấy danh sách homestays: $error");
    }
  }
}
