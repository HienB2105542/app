import 'package:flutter/material.dart';
import 'home.dart';
import '../profile/profile_screen.dart';
import '../favorites/favorites_screen.dart';
import '../bookings/booking_screen.dart';
import '../posts/create_post_create.dart';
import '../../models/homestay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Homestay> favoriteHomestays = []; // Changed to List<Homestay>

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFavoriteToggle(Homestay homestay, bool isFavorite) {
    // Changed parameter type to Homestay
    setState(() {
      if (isFavorite) {
        // Check if not already in favorites
        bool alreadyExists = false;
        for (var favorite in favoriteHomestays) {
          if (favorite.name == homestay.name) {
            // Changed to use object property
            alreadyExists = true;
            break;
          }
        }
        if (!alreadyExists) {
          favoriteHomestays.add(homestay);
        }
      } else {
        favoriteHomestays.removeWhere((item) =>
            item.name == homestay.name); // Changed to use object property
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Homestay Hinn"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          ).then((_) {
            // Refresh the screen when returning from create post
            setState(() {});
          });
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 248, 41, 26),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Yêu thích"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Đặt phòng"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Tài khoản"),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 1:
        return FavoritesScreen(
          favoriteHomestays: favoriteHomestays,
          onFavoriteToggle: (homestay, isFavorite) =>
              _onFavoriteToggle(homestay, isFavorite),
        );
      case 2:
        return const BookingScreen();
      case 3:
        return const ProfileScreen();
      default:
        return Home(
          favoriteHomestays: favoriteHomestays,
          onFavoriteToggle: _onFavoriteToggle,
        );
    }
  }
}
