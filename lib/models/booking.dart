// models/booking.dart
class Booking {
  final String id;
  final String homestayName;
  final String location;
  final String imageUrl;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String status;
  final double rating;
  final int nights;
  final double totalPrice;

  Booking({
    required this.id,
    required this.homestayName,
    required this.location,
    required this.imageUrl,
    required this.checkInDate,
    required this.checkOutDate,
    required this.status,
    this.rating = 0.0,
    required this.nights,
    required this.totalPrice,
  });

  Booking copyWith({
    String? id,
    String? homestayName,
    String? location,
    String? imageUrl,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    String? status,
    double? rating,
    int? nights,
    double? totalPrice,
  }) {
    return Booking(
      id: id ?? this.id,
      homestayName: homestayName ?? this.homestayName,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      nights: nights ?? this.nights,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
