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
      backgroundColor: Colors.grey[50],
      body: favoriteHomestays.isEmpty
          ? _buildEmptyState(context)
          : _buildFavoritesList(context),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 80,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Chưa có homestay nào được yêu thích",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Hãy lưu các homestay yêu thích của bạn ở đây",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text("Khám phá homestay"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Danh sách yêu thích của bạn",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: favoriteHomestays.length,
            itemBuilder: (context, index) {
              final homestay = favoriteHomestays[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      children: [
                        _buildHomestayImage(
                            homestay, constraints.maxWidth * 0.3),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homestay.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                _buildLocationRow(homestay),
                                const SizedBox(height: 5),
                                _buildPriceText(homestay),
                                const SizedBox(height: 5),
                                _buildActionButtons(homestay),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHomestayImage(Homestay homestay, double width) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      child: Image(
        image: AssetImage(homestay.imageUrl),
        width: width,
        height: width,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: width,
            color: Colors.grey[200],
            child: const Icon(
              Icons.home,
              color: Colors.grey,
              size: 50,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLocationRow(Homestay homestay) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          color: Colors.redAccent,
          size: 16,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            homestay.location,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceText(Homestay homestay) {
    return Text(
      "${homestay.price.toStringAsFixed(0)} VNĐ/đêm",
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.redAccent,
      ),
    );
  }

  Widget _buildActionButtons(Homestay homestay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: const Text("Đặt phòng"),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.favorite,
            color: Colors.redAccent,
          ),
          onPressed: () => onFavoriteToggle(homestay, false),
        ),
      ],
    );
  }
}
