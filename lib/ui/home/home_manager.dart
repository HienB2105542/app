import 'package:flutter/material.dart';
// import '../../services/home_service.dart';
import '../../models/homestay.dart';

class HomeManager with ChangeNotifier {
  // final HomeService _homeService = HomeService();
  final List<Homestay> _homestays = [
    Homestay(
      id: "1",
      name: "Homestay Sapa",
      description: "Không gian ấm cúng, gần gũi với thiên nhiên.",
      location: "Lào Cai",
      guests: 2,
      rooms: 1,
      price: 1200000.0,
      imageUrl: "assets/images/laocai.jpg",
      isFavorite: false,
    ),
    Homestay(
      id: "2",
      name: "Homestay Đà Lạt",
      description: "View rừng thông, không khí trong lành.",
      location: "Lâm Đồng",
      guests: 3,
      rooms: 2,
      price: 1500000.0,
      imageUrl: "assets/images/dalat.jpg",
      isFavorite: true,
    ),
    Homestay(
      id: "3",
      name: "Homestay Nha Trang",
      description: "Cách biển chỉ 5 phút đi bộ.",
      location: "Khánh Hòa",
      guests: 4,
      rooms: 2,
      price: 1800000.0,
      imageUrl: "assets/images/nhatrang.jpg",
      isFavorite: false,
    ),
    Homestay(
      id: "4",
      name: "Homestay Hà Nội",
      description: "Nằm ngay trung tâm, thuận tiện đi lại.",
      location: "Hà Nội",
      guests: 2,
      rooms: 1,
      price: 1000000.0,
      imageUrl: "assets/images/hanoi.jpg",
      isFavorite: true,
    ),
  ];

  int get itemCount {
    return _homestays.length;
  }

  List<Homestay> get homestays {
    return [..._homestays];
  }

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

}
