import 'package:flutter/material.dart';
import 'booking_item_card.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip("All", true),
                  _buildFilterChip("Upcoming", false),
                  _buildFilterChip("Completed", false),
                  _buildFilterChip("Cancelled", false),
                ],
              ),
            ),
          ),
          // Bookings list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12),
              itemCount: 1, 
              itemBuilder: (context, index) => BookingItemCard(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          // Add new booking
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          
        },
        backgroundColor: Colors.white,
        selectedColor: Colors.blue.shade100,
        checkmarkColor: Colors.blue.shade800,
      ),
    );
  }
}
