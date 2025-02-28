import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final PocketBase pb = PocketBase('http://10.0.0.2:8090');

  // Đăng ký + tự động đăng nhập sau khi đăng ký
  Future<bool> registerUser(String email, String password, String name) async {
    try {
      await pb.collection('users').create(body: {
        "email": email,
        "password": password,
        "passwordConfirm": password,
        "name": name,
      });

      // Sau khi đăng ký, tự động đăng nhập
      return await loginUser(email, password);
    } catch (e) {
      print("Lỗi đăng ký: $e");
      return false;
    }
  }

// Đăng nhập + Lưu token
  Future<bool> loginUser(String email, String password) async {
    try {
      final authData =
          await pb.collection('users').authWithPassword(email, password);

      if (authData.record != null) {
        // Lưu token vào local storage để giữ trạng thái đăng nhập
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', authData.token);
        await prefs.setString('userId',
            authData.record!.id); // Sử dụng dấu '!' sau khi kiểm tra null

        print("Đăng nhập thành công! Token: ${authData.token}");
        return true;
      } else {
        print("Lỗi: Không thể lấy thông tin người dùng sau khi đăng nhập.");
        return false;
      }
    } catch (e) {
      print("Lỗi đăng nhập: $e");
      return false;
    }
  }

  // Kiểm tra xem user có đăng nhập hay không
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token != null && token.isNotEmpty) {
      pb.authStore.save(token, null);
      return true;
    }
    return false;
  }

  // Đăng xuất
  Future<void> logout() async {
    pb.authStore.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    await prefs.remove('userId');
  }
}
