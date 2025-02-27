import 'package:flutter/material.dart';
import '../../models/homestay.dart';
import 'booking_form.dart';
class DetailScreen extends StatelessWidget {
  final Homestay homestay;

  const DetailScreen({super.key, required this.homestay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homestay.name),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    homestay.imageUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          homestay.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.redAccent),
                            const SizedBox(width: 5),
                            Text(homestay.location,
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.group, color: Colors.redAccent),
                            const SizedBox(width: 5),
                            Text(homestay.guests,
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.hotel, color: Colors.redAccent),
                            const SizedBox(width: 5),
                            Text("${homestay.rooms} phòng ngủ",
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Giá: ${homestay.price.toStringAsFixed(0)} đ/đêm",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Mô tả",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          homestay.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Tiện nghi",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        _buildAmenities(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingFormScreen(homestay: homestay),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Đặt phòng ngay",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenities() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildAmenityChip(Icons.wifi, "Wifi miễn phí"),
        _buildAmenityChip(Icons.ac_unit, "Điều hòa"),
        _buildAmenityChip(Icons.tv, "TV"),
        _buildAmenityChip(Icons.kitchen, "Bếp"),
        _buildAmenityChip(Icons.local_parking, "Bãi đỗ xe"),
        _buildAmenityChip(Icons.hot_tub, "Nước nóng"),
      ],
    );
  }

  Widget _buildAmenityChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      backgroundColor: Colors.grey[200],
    );
  }
}
