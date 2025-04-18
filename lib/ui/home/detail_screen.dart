import 'package:flutter/material.dart';
import 'package:homestay/ui/bookings/booking_form.dart';
import '../../models/homestay.dart';

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
                  homestay.imageUrl.isNotEmpty
                      ? Image.network(
                          homestay.imageUrl,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/dalat.jpg',
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          'assets/images/dalat.jpg',
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
                            Text("${homestay.guests} khách",
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Giá: ${homestay.price} VNĐ",
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
                          homestay.description.isNotEmpty
                              ? homestay.description
                              : "Chưa có mô tả.",
                          style: const TextStyle(fontSize: 16),
                        ),
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
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Đặt phòng ngay",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
