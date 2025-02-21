import 'package:flutter/material.dart';
import '../../models/booking.dart';

class BookingManager extends ChangeNotifier {
  final List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void removeBooking(String id) {
    _bookings.removeWhere((booking) => booking.id == id);
    notifyListeners();
  }
}
