import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../auth/login_screen.dart';
import 'profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await _authService.getCurrentUser();
    print("User data: $user");

    if (user != null) {
      if (mounted) {
        setState(() {
          userData = user;
        });
      }
    } else {
      print("Không có dữ liệu người dùng, nhưng không đăng xuất ngay!");
      Future.delayed(const Duration(seconds: 3), () async {
        final retryUser = await _authService.getCurrentUser();
        if (mounted && retryUser == null) {
          _logout();
        }
      });
    }
  }

  void _logout() async {
    await _authService.logout();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thông báo'),
        content: const Text('Chức năng đang được phát triển'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Hồ sơ của tôi',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black54),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: userData == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ProfileHeader(
                    userData: userData,
                    onEditProfile: _editProfile,
                  ),
                  const SizedBox(height: 20),
                  ProfileInfoCard(
                    icon: Icons.phone,
                    title: 'Số điện thoại',
                    value: userData?['phone'],
                    onTap: () {},
                  ),
                  ProfileInfoCard(
                    icon: Icons.location_on,
                    title: 'Địa chỉ',
                    value: userData?['address'],
                    onTap: () {},
                  ),
                  ProfileInfoCard(
                    icon: Icons.settings,
                    title: 'Cài đặt tài khoản',
                    onTap: () {},
                  ),
                  const SizedBox(height: 30),
                  LogoutButton(onLogout: _logout),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
