import 'package:flutter/material.dart';
import 'booking_item_card.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Bookings")),
      body: ListView(
        children: [
          BookingItemCard(),
          BookingItemCard(), // Replace with dynamic bookings data
        ],
      ),
    );
  }
}
