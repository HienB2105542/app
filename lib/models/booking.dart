import 'package:intl/intl.dart';
class Booking {
  final String? id;
  final String homestayId;
  final String homestayName;
  final String phone;
  final String location;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String status;
  final double rating; 
  final int nights;
  final double totalPrice; 
  final String userId;

  Booking({
     this.id,
    required this.homestayId,
    required this.homestayName,
    required this.phone,
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
      String? phone,
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
      phone: phone ?? this.phone,
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

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

    return {
      "id": id.toString(),
      "homestayId": homestayId,
      "homestayName": homestayName,
      "phone": phone,
      "location": location,
      "checkInDate":
          dateFormat.format(checkInDate.toUtc()), 
      "checkOutDate": dateFormat.format(checkOutDate.toUtc()),
      "status": status,
      "rating": rating,
      "nights": nights,
      "totalPrice": totalPrice,
      "userId": userId.toString(), 
    };
  }
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      homestayId: json['homestayId'],
      homestayName: json['homestayName'] ?? '',
      phone: json['phone'] ?? '',
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
