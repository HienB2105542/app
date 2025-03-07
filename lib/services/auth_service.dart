import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String pocketBaseUrl =
      'http://127.0.0.1:8090/api/collections/users/auth-with-password';

  //lấy thông tin tài khoản
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    print("Lấy dữ liệu user từ Share: $userData"); //Db
    if (userData != null) {
      final decodedData = jsonDecode(userData);
      return decodedData['id'];
    }
    return null;
  }

  // Đăng nhập
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(pocketBaseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identity': email, 'password': password}),
      );

      print("📡 API response: ${response.body}"); //Xem dữ liệu trả về từ API

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await saveUserData(data);

        final userId = await getUserId();
        print("User ID sau khi đăng nhập: $userId");
        
        return true;
      } else {
        print('Lỗi đăng nhập: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Lỗi kết nối đăng nhập: $e');
      return false;
    }
  }

  // Đăng ký
  Future<bool> register(String email, String password, String name) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8090/api/collections/users/records'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password, 'name': name}),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Lỗi đăng ký: $e');
      return false;
    }
  }

  // Lưu thông tin đăng nhập
  Future<void> saveUserData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    print("Dữ liệu trước khi lưu: ${jsonEncode(data)}");
    if (data.containsKey('record')) {
      await prefs.setString('user', jsonEncode(data['record']));
      await prefs.setString('token', data['token']);
      print("Lưu thành công: ${jsonEncode(data['record'])}");
    } else {
      print("Lưu thất bại: Dữ liệu không đúng");
    }
  }

  // Lấy thông tin người dùng hiện tại
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    print("Stored user data: $userData"); // Debug xem có dữ liệu không
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  // Đăng xuất
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Kiểm tra đăng nhập
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  Future<void> debugLoginState() async {
    final userId = await getUserId();
    final isLogged = await isLoggedIn();

    print("User ID: $userId");
    print("Đã đăng nhập? $isLogged");
  }
}
