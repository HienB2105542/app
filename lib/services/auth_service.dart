import 'package:pocketbase/pocketbase.dart';

class AuthService {
  // final PocketBase pb = PocketBase('http://127.0.0.1:8090');
  final PocketBase pb = PocketBase('http://10.0.2.2:8090');

  // Đăng ký
  Future<bool> registerUser(String email, String password, String name) async {
    try {
      await pb.collection('users').create(body: {
        "email": email,
        "password": password,
        "passwordConfirm": password,
        "name": name,
      });
      return true; // Thành công
    } catch (e) {
      print("Lỗi đăng ký: $e");
      return false; // Thất bại
    }
  }

  // Đăng nhập
  Future<bool> loginUser(String email, String password) async {
    print("Đang thử đăng nhập với email: $email");
    try {
      final authData =
          await pb.collection('users').authWithPassword(email, password);
      print("Đăng nhập thành công! Token: ${authData.token}");
      return true;
    } catch (e) {
      print("Lỗi đăng nhập chi tiết: $e");
      // Thử in thêm thông tin để debug
      print("Stack trace: ${StackTrace.current}");
      return false;
    }
  }

  // Kiểm tra trạng thái đăng nhập
  bool isLoggedIn() {
    return pb.authStore.isValid;
  }

  // Đăng xuất
  void logout() {
    pb.authStore.clear();
  }
}
