import 'package:flutter/material.dart';
import '../../models/homestay.dart';
class FavoritesScreen extends StatelessWidget {
  final List<Homestay> favoriteHomestays;
  final Function(Homestay, bool) onFavoriteToggle;

  const FavoritesScreen({
    super.key,
    required this.favoriteHomestays,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yêu thích"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: favoriteHomestays.isEmpty
          ? const Center(
              child: Text(
                "Chưa có homestay nào được yêu thích.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: favoriteHomestays.length,
              itemBuilder: (context, index) {
                final homestay = favoriteHomestays[index];
                return ListTile(
                  leading: Image.asset(
                    homestay.imageUrl ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(homestay.name),
                  subtitle: Text(homestay.location),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () =>
                        onFavoriteToggle(homestay, false), // Xóa khỏi yêu thích
                  ),
                );
              },
            ),
    );
  }
}
