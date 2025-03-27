import 'package:intl/intl.dart';
class Booking {
  final String id;
  final String homestayId;
  final String homestayName;
  final String location;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String status; //Trạng thái
  final double rating; //đánh giá
  final int nights; //khách ở bao nhiêu đêm
  final double totalPrice; //Tổng số tiền khách phải trả
  final String userId;

  Booking({
    required this.id,
    required this.homestayId,
    required this.homestayName,
    required this.location,
    required this.checkInDate,
    required this.checkOutDate,
    required this.status,
    this.rating = 0.0,
    required this.nights,
    required this.totalPrice,
    required this.userId,
  });

  Booking copyWith(
      {String? id,
      String? homestayId,
      String? homestayName,
      String? location,
      DateTime? checkInDate,
      DateTime? checkOutDate,
      String? status,
      double? rating,
      int? nights,
      double? totalPrice,
      String? userId}) {
    return Booking(
      id: id ?? this.id,
      homestayId: homestayId ?? this.homestayId,
      homestayName: homestayName ?? this.homestayName,
      location: location ?? this.location,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      nights: nights ?? this.nights,
      totalPrice: totalPrice ?? this.totalPrice,
      userId: userId ?? this.userId,
    );
  }

  // Chuyển đổi từ Booking sang JSON
  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

    return {
      "id": id.toString(),
      "homestayId": homestayId,
      "homestayName": homestayName,
      "location": location,
      "checkInDate":
          dateFormat.format(checkInDate.toUtc()), // Chuyển đổi DateTime sang String
      "checkOutDate": dateFormat.format(checkOutDate.toUtc()),
      "status": status,
      "rating": rating,
      "nights": nights,
      "totalPrice": totalPrice,
      "userId": userId.toString(), 
    };
  }
  // Chuyển đổi từ JSON sang Booking
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      homestayId: json['homestayId'],
      homestayName: json['homestayName'] ?? '',
      location: json['location'],
      checkInDate: DateTime.parse(json['checkInDate']),
      checkOutDate: DateTime.parse(json['checkOutDate']),
      status: json['status'],
      rating: (json['rating'] as num).toDouble(),
      nights: json['nights'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      userId: json['userId'],
    );
  }
}
