import 'package:flutter/material.dart';
import '../../models/booking.dart';

enum BookingStatus { upcoming, completed, cancelled }

class BookingManager extends ChangeNotifier {
  final List<Booking> _bookings = [];
  BookingStatus _currentFilter = BookingStatus.upcoming;

  List<Booking> get bookings {
    if (_currentFilter == BookingStatus.upcoming) {
      return _bookings
          .where((booking) =>
              booking.status == 'confirmed' || booking.status == 'pending')
          .toList();
    } else if (_currentFilter == BookingStatus.completed) {
      return _bookings
          .where((booking) => booking.status == 'completed')
          .toList();
    } else {
      return _bookings
          .where((booking) => booking.status == 'cancelled')
          .toList();
    }
  }

  List<Booking> get allBookings => _bookings;

  BookingStatus get currentFilter => _currentFilter;

  void setFilter(BookingStatus filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void removeBooking(String id) {
    _bookings.removeWhere((booking) => booking.id == id);
    notifyListeners();
  }

  void updateBookingStatus(String id, String status) {
    final index = _bookings.indexWhere((booking) => booking.id == id);
    if (index != -1) {
      _bookings[index] = _bookings[index].copyWith(status: status);
      notifyListeners();
    }
  }

  // Method to search bookings
  List<Booking> searchBookings(String query) {
    if (query.isEmpty) {
      return bookings;
    }

    return bookings
        .where((booking) =>
            booking.homestayId.toLowerCase().contains(query.toLowerCase()) ||
            booking.location.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
