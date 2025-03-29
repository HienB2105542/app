import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookService {
  static const String _baseUrl = 'http://10.0.2.2:8090';
  final PocketBase _pb;
  static const String _bookingsCollection = 'booking';

  BookService() : _pb = PocketBase(_baseUrl);

  Future<List<Booking>> getBookings(String userId) async {
    try {
      final records = await _pb.collection(_bookingsCollection).getList(
            filter: 'userId = "$userId"',
            sort: '-created',
          );

      return records.items.map((record) {
        final data = record.data;
        data['id'] = record.id; 
        return Booking.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error getting bookings: $e');
      return [];
    }
  }

  
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    print("User ID từ SharedPreferences: $userId");
    return userId;
  }

Future<bool> createBooking(Booking booking) async {
    try {
      final bookingJson = booking.toJson();
      print("Full Booking JSON: $bookingJson");

      final response = await http.post(
        Uri.parse('$_baseUrl/api/collections/booking/records'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(bookingJson),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Đặt phòng thành công!");
        return true;
      } else {
        print("Lỗi khi gửi API: ${response.body}");
        return false;
      }
    } catch (error) {
      print("Lỗi kết nối API: $error");
      return false;
    }
  }

  Future<bool> updateBookingStatus(String bookingId, String status) async {
    try {
      await _pb.collection(_bookingsCollection).update(
        bookingId,
        body: {'status': status},
      );
      return true;
    } catch (e) {
      print('Error updating booking status: $e');
      return false;
    }
  }

  Future<bool> deleteBooking(String bookingId) async {
    try {
      await _pb.collection(_bookingsCollection).delete(bookingId);
      return true;
    } catch (e) {
      print('Error deleting booking: $e');
      return false;
    }
  }
}
