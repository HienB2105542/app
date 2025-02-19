import 'package:flutter/material.dart';
import 'home.dart';
import '../profile/profile_screen.dart';
// import '../profile/user_profile_card.dart';
import '../favorites/favorites_screen.dart';
import '../../models/homestay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; //luu trang thai cua bottom navigation bar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _onFavoriteToggle(Homestay homestay) {
    setState(() {
      if (favoriteHomestays.contains(homestay)) {
        favoriteHomestays.remove(homestay);
      } else {
        favoriteHomestays.add(homestay);
      }
    });
  }
  static List<Homestay> favoriteHomestays = []; // Danh sách homestay yêu thích
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
          onFavoriteToggle: _onFavoriteToggle,
        );
      case 2:
        return const Center(
            child: Text(
          "Trang Đặt Phòng",
          style: TextStyle(fontSize: 20),
        ));
      case 3:
        return const ProfileScreen();
      default:
        return const Home();
    }
  }
}
