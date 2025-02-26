import 'package:flutter/material.dart';
import '../homestays/detail_screen.dart';
import '../../models/homestay.dart';

class HomeCard extends StatefulWidget {
  final Homestay homestay;
  final Function(Homestay, bool) onFavoriteToggle;
  final List<Homestay> favoriteHomestays;

  const HomeCard({
    super.key,
    required this.homestay,
    required this.onFavoriteToggle,
    required this.favoriteHomestays,
  });

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() {
    for (var favorite in widget.favoriteHomestays) {
      if (favorite.name == widget.homestay.name) {
        setState(() {
          isFavorite = true;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              homestay: widget.homestay,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      widget.homestay.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        widget.onFavoriteToggle(widget.homestay, isFavorite);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.homestay.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(widget.homestay.location,
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 5),
                  Text(widget.homestay.guests,
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 5),
                  Text(
                    widget.homestay.price.toString(),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
