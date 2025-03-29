import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String pocketBaseUrl =
      'http://127.0.0.1:8090/api/collections/users/auth-with-password';

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    print("Lấy dữ liệu user từ Share: $userData"); 
    if (userData != null) {
      final decodedData = jsonDecode(userData);
      return decodedData['id'];
    }
    return null;
  }

    Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(pocketBaseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identity': email, 'password': password}),
      );

      print("API response: ${response.body}"); 

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
  

   Future<void> saveUserData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();

    if (data.containsKey('record') && data.containsKey('token')) {
      await prefs.setString('userId', data['record']['id']);
      await prefs.setString('authToken', data['token']);
      print("User ID đã lưu: ${data['record']['id']}");
      print("Token đã lưu: ${data['token']}");
    } else {
      print("Dữ liệu đăng nhập không hợp lệ!");
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    print("Stored user data: $userData"); 
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

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
