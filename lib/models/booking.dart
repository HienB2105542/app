class Booking {
  final String id;
  final String homestayName;
  final String userName;
  final DateTime checkIn;
  final DateTime checkOut;
  final double totalPrice;

  Booking({
    required this.id,
    required this.homestayName,
    required this.userName,
    required this.checkIn,
    required this.checkOut,
    required this.totalPrice,
  });

  // Convert Booking to Map (for saving to DB or local storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'homestayName': homestayName,
      'userName': userName,
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'totalPrice': totalPrice,
    };
  }

  // Create Booking from Map
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      homestayName: map['homestayName'],
      userName: map['userName'],
      checkIn: DateTime.parse(map['checkIn']),
      checkOut: DateTime.parse(map['checkOut']),
      totalPrice: map['totalPrice'],
    );
  }
}
