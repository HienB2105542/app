import '../../models/homestay.dart';
class HomeManager {
  static List<Homestay> homestays = [
    Homestay(
      id: "1",
      name: "Homestay Sapa",
      description: "Không gian ấm cúng, gần gũi với thiên nhiên.",
      location: "Lào Cai",
      guests: "2 khách, 1 phòng ngủ",
      imageUrl: "assets/images/laocai.jpg",
      price: 1200000.0,
      rooms: 1,
    ),
    Homestay(
      id: "2",
      name: "Homestay Đà Lạt",
      description: "View rừng thông, không khí trong lành.",
      location: "Lâm Đồng",
      guests: "3 khách, 2 phòng ngủ",
      imageUrl: "assets/images/dalat.jpg",
      price: 1500000.0,
      rooms: 2,
    ),
    Homestay(
      id: "3",
      name: "Homestay Nha Trang",
      description: "Cách biển chỉ 5 phút đi bộ.",
      location: "Khánh Hòa",
      guests: "4 khách, 2 phòng ngủ",
      imageUrl: "assets/images/nhatrang.jpg",
      price: 1800000.0,
      rooms: 2,
    ),
    Homestay(
      id: "4",
      name: "Homestay Hà Nội",
      description: "Nằm ngay trung tâm, thuận tiện đi lại.",
      location: "Hà Nội",
      guests: "2 khách, 1 phòng ngủ",
      imageUrl: "assets/images/hanoi.jpg",
      price: 1000000.0,
      rooms: 1,
    ),
  ];
}
