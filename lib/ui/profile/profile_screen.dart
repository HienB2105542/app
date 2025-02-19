import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Username: User123'),
            Text('Email: user@example.com'),
            ElevatedButton(
              onPressed: () {
                // Handle logout
              },
              child: Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
