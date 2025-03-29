import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/booking.dart';
import 'booking_item_card.dart';
import 'booking_manager.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _currentFilter = "All";
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _fetchBookings();
      _isInit = true;
    }
  }

  Future<void> _fetchBookings() async {
    final userId = 'userId'; 
    await Provider.of<BookingManager>(context, listen: false)
        .fetchBookings(userId);
  }

  List<Booking> _getFilteredBookings(List<Booking> bookings) {
    if (_currentFilter == "All") {
      return bookings;
    } else if (_currentFilter == "Upcoming") {
      return bookings
          .where((booking) =>
              booking.status.toLowerCase() == 'pending' ||
              booking.status.toLowerCase() == 'confirmed')
          .toList();
    } else if (_currentFilter == "Completed") {
      return bookings
          .where((booking) => booking.status.toLowerCase() == 'completed')
          .toList();
    } else if (_currentFilter == "Cancelled") {
      return bookings
          .where((booking) => booking.status.toLowerCase() == 'cancelled')
          .toList();
    }
    return bookings;
  }

  @override
  Widget build(BuildContext context) {
    final bookingManager = Provider.of<BookingManager>(context);
    final bookings = bookingManager.bookings;
    final filteredBookings = _getFilteredBookings(bookings);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _fetchBookings,
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildFilterChip("All", _currentFilter == "All"),
                    _buildFilterChip("Upcoming", _currentFilter == "Upcoming"),
                    _buildFilterChip(
                        "Completed", _currentFilter == "Completed"),
                    _buildFilterChip(
                        "Cancelled", _currentFilter == "Cancelled"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: bookingManager.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredBookings.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.hotel_outlined,
                                  size: 60, color: Colors.grey),
                              const SizedBox(height: 16),
                              Text(
                                'Bạn chưa có đặt phòng nào',
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/homestays');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Tìm phòng ngay'),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 12),
                          itemCount: filteredBookings.length,
                          itemBuilder: (context, index) => BookingItemCard(
                            booking: filteredBookings[index],
                          ),
                        ),
            ),
          ],
        ),
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
          if (selected) {
            setState(() {
              _currentFilter = label;
            });
          }
        },
        backgroundColor: Colors.white,
        selectedColor: Colors.redAccent.withOpacity(0.2),
        checkmarkColor: Colors.redAccent,
      ),
    );
  }
}
