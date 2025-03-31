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
      _fetchAllBookings();
      _isInit = true;
    }
  }

  Future<void> _fetchAllBookings() async {
    await Provider.of<BookingManager>(context, listen: false)
        .fetchAllBookings();
  }

  List<Booking> _getFilteredBookings(List<Booking> bookings) {
    switch (_currentFilter) {
      case "Upcoming":
        return bookings
            .where((b) =>
                b.status.toLowerCase() == 'pending' ||
                b.status.toLowerCase() == 'confirmed')
            .toList();
      case "Completed":
        return bookings
            .where((b) => b.status.toLowerCase() == 'completed')
            .toList();
      case "Cancelled":
        return bookings
            .where((b) => b.status.toLowerCase() == 'cancelled')
            .toList();
      default:
        return bookings;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Danh sách đặt phòng")),
      body: Consumer<BookingManager>(
        builder: (context, bookingManager, child) {
          if (bookingManager.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final filteredBookings =
              _getFilteredBookings(bookingManager.bookings);

          if (filteredBookings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.hotel_outlined,
                      size: 60, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Bạn chưa có đặt phòng nào',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
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
            );
          }

          return Column(
            children: [
              _buildFilterChips(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 12),
                  itemCount: filteredBookings.length,
                  itemBuilder: (context, index) => BookingItemCard(
                    booking: filteredBookings[index],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildFilterChip("All"),
            _buildFilterChip("Upcoming"),
            _buildFilterChip("Completed"),
            _buildFilterChip("Cancelled"),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: _currentFilter == label,
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
