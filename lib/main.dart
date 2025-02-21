import 'package:flutter/material.dart';
import 'package:homestay/ui/homestays/homestay_list.dart';
import 'screens.dart';
import 'ui/home/home_screen.dart';
import 'ui/bookings/booking_screen.dart';
import 'ui/auth/login_screen.dart';
import 'ui/profile/profile_screen.dart';
import 'ui/home/intro.dart';

void main() {
  runApp(MyApp());
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
        AppScreens.intro: (ctx) => WelcomeScreen(),
        AppScreens.home: (ctx) => HomeScreen(),
        AppScreens.login: (ctx) => LoginScreen(),
        AppScreens.bookings: (ctx) => BookingScreen(),
        AppScreens.profile: (ctx) => ProfileScreen(),
        AppScreens.homestaylist: (ctx) => HomestayListScreen(),
      },
    );
  }
}
