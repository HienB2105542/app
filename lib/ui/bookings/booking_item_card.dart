import 'package:flutter/material.dart';

class BookingItemCard extends StatelessWidget {
  const BookingItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(Icons.hotel),
        title: Text('Homestay Name'),
        subtitle: Text('Check-in: 2025-02-19'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Navigate to booking detail
        },
      ),
    );
  }
}
