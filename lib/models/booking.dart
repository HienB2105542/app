class Booking {
  final String id;
  final String homestayId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String userId;

  Booking({
    required this.id,
    required this.homestayId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.userId,
  });
}
