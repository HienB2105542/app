import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('App Menu')),
          ListTile(
            title: Text('Home'),
            onTap: () {
              // Navigate to home screen
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Navigate to profile screen
            },
          ),
          ListTile(
            title: Text('Bookings'),
            onTap: () {
              // Navigate to bookings screen
            },
          ),
        ],
      ),
    );
  }
}
