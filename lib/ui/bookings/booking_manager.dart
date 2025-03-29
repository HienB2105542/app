import 'package:flutter/foundation.dart';
import '../../models/booking.dart';
import '../../services/book_service.dart';

class BookingManager with ChangeNotifier {
  final BookService _pocketBaseService = BookService();
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  List<Booking> get bookings => [..._bookings];
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Lấy tất cả bookings của người dùng
  Future<void> fetchBookings(String userId) async {
    _setLoading(true);
    try {
      _bookings = await _pocketBaseService.getBookings(userId);
      _error = null;
    } catch (error) {
      _error = 'Không thể tải danh sách đặt phòng.';
      print(error);
    }
    _setLoading(false);
  }

  // Thêm booking mới
Future<bool> addBooking(Booking booking) async {
  _setLoading(true);
  try {
    print("Gửi dữ liệu đặt phòng: ${booking.toJson()}"); 
    final success = await _pocketBaseService.createBooking(booking);
    
    if (success) {
      _bookings.add(booking);
      _error = null;
      notifyListeners();
    }
    
    _setLoading(false);
    return success;
  } catch (error) {
    _error = 'Không thể tạo đặt phòng mới.';
    _setLoading(false);
    print("Lỗi khi đặt phòng: $error"); 
    return false;
  }
}


  // Xác nhận booking (cho admin)
  Future<bool> confirmBooking(String bookingId) async {
    return await _updateBookingStatus(bookingId, 'confirmed');
  }

  // Hoàn thành booking
  Future<bool> completeBooking(String bookingId) async {
    return await _updateBookingStatus(bookingId, 'completed');
  }

  // Hủy booking
  Future<bool> cancelBooking(String bookingId) async {
    return await _updateBookingStatus(bookingId, 'cancelled');
  }

  // Xóa booking
  Future<bool> deleteBooking(String bookingId) async {
    _setLoading(true);
    try {
      final success = await _pocketBaseService.deleteBooking(bookingId);
      if (success) {
        _bookings.removeWhere((booking) => booking.id == bookingId);
        _error = null;
        notifyListeners();
      }
      _setLoading(false);
      return success;
    } catch (error) {
      _error = 'Không thể xóa đặt phòng.';
      _setLoading(false);
      print(error);
      return false;
    }
  }

  // Cập nhật trạng thái booking
  Future<bool> _updateBookingStatus(String bookingId, String status) async {
    _setLoading(true);
    try {
      final success =
          await _pocketBaseService.updateBookingStatus(bookingId, status);
      if (success) {
        final index =
            _bookings.indexWhere((booking) => booking.id == bookingId);
        if (index >= 0) {
          _bookings[index] = _bookings[index].copyWith(status: status);
          _error = null;
          notifyListeners();
        }
      }
      _setLoading(false);
      return success;
    } catch (error) {
      _error = 'Không thể cập nhật trạng thái đặt phòng.';
      _setLoading(false);
      print(error);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
