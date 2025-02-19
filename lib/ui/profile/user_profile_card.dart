import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.account_circle),
        title: Text('User123'),
        subtitle: Text('user@example.com'),
        onTap: () {
          // Handle navigation to profile details
        },
      ),
    );
  }
}
