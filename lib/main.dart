import 'package:flutter/material.dart';
import 'ui/screens.dart';
import 'ui/home/home_screen.dart';
import 'ui/bookings/booking_screen.dart';
import 'ui/auth/login_screen.dart';
import 'ui/home/profile_screen.dart';
import 'package:provider/provider.dart';
import 'ui/home/home_manager.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  // await dotenv.load();
  // runApp(const MyApp());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeManager()),
      ],
      child: MyApp(),
    ),
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
