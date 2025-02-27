class Booking {
  final String id;
  final String userName;
  final String homestayName;
  final String email;
  final String phone;
  final int guests;
  final DateTime checkIn;
  final DateTime checkOut;

  Booking({
    required this.id,
    required this.userName,
    required this.homestayName,
    required this.email,
    required this.phone,
    required this.guests,
    required this.checkIn,
    required this.checkOut,
    required String name,
    required double totalPrice,
  });

  get totalPrice => null;
}
