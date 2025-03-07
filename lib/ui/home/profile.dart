import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final Map<String, dynamic>? userData;
  final VoidCallback onEditProfile;

  const ProfileHeader({
    super.key,
    required this.userData,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade300, Colors.blue.shade100],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: (userData?['avatar'] != null &&
                          userData!['avatar'].isNotEmpty &&
                          Uri.tryParse(userData!['avatar'])?.hasAbsolutePath ==
                              true)
                      ? NetworkImage(userData!['avatar'])
                      : const AssetImage('assets/images/logo.png')
                          as ImageProvider,

                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onEditProfile,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            userData?['name'] ?? 'Người dùng',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            userData?['email'] ?? 'Không có email',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback? onTap;

  const ProfileInfoCard({
    Key? key,
    required this.icon,
    required this.title,
    this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2,
        child: ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(title),
          subtitle: Text(value ?? 'Chưa cập nhật'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutButton({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onLogout,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(double.infinity, 50),
          elevation: 3,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout),
            SizedBox(width: 8),
            Text(
              'Đăng xuất',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
