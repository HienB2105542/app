import 'package:flutter/material.dart';
// import '../home/home_card.dart';
import '../../models/homestay.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Homestay> favoriteHomestays;
  final Function(Homestay) onFavoriteToggle;

  const FavoritesScreen({
    super.key,
    required this.favoriteHomestays,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yêu thích")),
      body: favoriteHomestays.isEmpty
          ? const Center(child: Text("Chưa có homestay nào được yêu thích."))
          : ListView.builder(
              itemCount: favoriteHomestays.length,
              itemBuilder: (context, index) {
                final homestay = favoriteHomestays[index];
                return ListTile(
                  title: Text(homestay.name),
                  subtitle: Text(homestay.location),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => onFavoriteToggle(homestay),
                  ),
                );
              },
            ),
    );
  }
}
