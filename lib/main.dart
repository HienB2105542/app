import 'package:flutter/material.dart';
import 'package:homestay/ui/home/home_manager.dart';
import 'package:path/path.dart';
import 'ui/screens.dart';
import 'ui/home/home_screen.dart';
import 'ui/bookings/booking_screen.dart';
import 'ui/auth/login_screen.dart';
import 'ui/home/profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeManager()..fetchHomestays(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homestay App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppScreens.home,
      routes: {
        AppScreens.home: (ctx) => HomeScreen(),
        AppScreens.login: (ctx) => LoginScreen(),
        AppScreens.bookings: (ctx) => BookingScreen(),
        AppScreens.profile: (ctx) => ProfileScreen(),
      },
    );
  }
}
