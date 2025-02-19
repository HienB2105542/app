import 'package:flutter/material.dart';

import 'ui/home/home_screen.dart';
import 'ui/bookings/booking_screen.dart';
import 'ui/auth/login_screen.dart';
import 'ui/profile/profile_screen.dart';
import 'ui/homestays/homestay_list.dart';
import 'ui/favorites/favorites_screen.dart';
import '../models/homestay.dart';

class AppScreens {
  static const String home = '/';
  static const String login = '/login';
  static const String bookings = '/bookings';
  static const String profile = '/profile';
  static const String detail = '/detail';
  static const String homestaylist = '/homestay_list';
  static const String favorites = '/favorites';


  static List<Homestay> favoriteHomestays = []; // Danh sách homestay yêu thích

  static void onFavoriteToggle(Homestay homestay) {
    if (favoriteHomestays.contains(homestay)) {
      favoriteHomestays.remove(homestay);
    } else {
      favoriteHomestays.add(homestay);
    }
  }

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomeScreen(),
    login: (context) => LoginScreen(),
    bookings: (context) => BookingScreen(),
    profile: (context) => ProfileScreen(),
    detail: (context) => ProfileScreen(),
    homestaylist: (context) => HomestayListScreen(),
    favorites: (context) => FavoritesScreen(
          favoriteHomestays: favoriteHomestays,
          onFavoriteToggle: onFavoriteToggle,
        ),
  };
}
