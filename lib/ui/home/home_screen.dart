import 'package:flutter/material.dart';

import '../../models/homestay.dart';
import '../auth/login_screen.dart';
import '../bookings/booking_screen.dart';
import '../favorites/favorites_screen.dart';
import 'create_post_screen.dart';
import 'home.dart';
import 'home_manager.dart';
import 'profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Homestay> favoriteHomestays = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<HomeManager>(context, listen: false).fetchHomestays());
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFavoriteToggle(Homestay homestay, bool isFavorite) {
    setState(() {
      if (isFavorite) {
        if (!favoriteHomestays.any((item) => item.name == homestay.name)) {
          favoriteHomestays.add(homestay);
        }
      } else {
        favoriteHomestays.removeWhere((item) => item.name == homestay.name);
      }
    });
  }

  void _fetchHomestays() async {
    await HomeManager().fetchHomestays();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Homestay Hinn",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          ).then((_) => setState(() {}));
        },
        elevation: 5,
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: "Yêu thích",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: "Đặt phòng",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Tài khoản",
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 1:
        return FavoritesScreen(
          favoriteHomestays: favoriteHomestays,
          onFavoriteToggle: _onFavoriteToggle,
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
