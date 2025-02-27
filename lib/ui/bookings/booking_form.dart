import 'package:flutter/material.dart';
import '../../models/homestay.dart';
import '../../models/booking.dart';
import 'booking_manager.dart';
import 'package:provider/provider.dart';

class BookingFormScreen extends StatefulWidget {
  final Homestay homestay;

  const BookingFormScreen({super.key, required this.homestay});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _checkInDate;
  late DateTime _checkOutDate;
  String _userName = '';
  double _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _checkInDate = DateTime.now().add(const Duration(days: 1));
    _checkOutDate = DateTime.now().add(const Duration(days: 2));
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    // Calculate number of nights
    final nights = _checkOutDate.difference(_checkInDate).inDays;
    setState(() {
      _totalPrice = widget.homestay.price * nights;
    });
  }

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkInDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _checkInDate) {
      setState(() {
        _checkInDate = picked;
        // Ensure check-out date is after check-in date
        if (_checkOutDate.isBefore(_checkInDate) ||
            _checkOutDate.isAtSameMomentAs(_checkInDate)) {
          _checkOutDate = _checkInDate.add(const Duration(days: 1));
        }
        _calculateTotalPrice();
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkOutDate.isAfter(_checkInDate)
          ? _checkOutDate
          : _checkInDate.add(const Duration(days: 1)),
      firstDate: _checkInDate.add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _checkOutDate) {
      setState(() {
        _checkOutDate = picked;
        _calculateTotalPrice();
      });
    }
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a new booking
      final booking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: widget.homestay.name,
        userName: _userName,
        homestayName: '',
        email: '',
        phone: '',
        guests: 1,
        checkIn: _checkInDate,
        checkOut: _checkOutDate,
        totalPrice: _totalPrice, 
      );

      // Add booking to the manager
      final bookingManager =
          Provider.of<BookingManager>(context, listen: false);
      bookingManager.addBooking(booking);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đặt phòng thành công!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to home or bookings screen
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt phòng'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Homestay info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.homestay.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.homestay.location),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.person, size: 16),
                          const SizedBox(width: 4),
                          Text(widget.homestay.guests),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // User name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Họ và tên',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ và tên';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userName = value!;
                },
              ),

              const SizedBox(height: 20),

              // Check-in date
              ListTile(
                title: const Text('Ngày nhận phòng'),
                subtitle: Text(
                    '${_checkInDate.day}/${_checkInDate.month}/${_checkInDate.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectCheckInDate(context),
              ),

              const Divider(),

              // Check-out date
              ListTile(
                title: const Text('Ngày trả phòng'),
                subtitle: Text(
                    '${_checkOutDate.day}/${_checkOutDate.month}/${_checkOutDate.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectCheckOutDate(context),
              ),

              const SizedBox(height: 20),

              // Price information
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Chi tiết giá',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${widget.homestay.price.toStringAsFixed(0)} đ x ${_checkOutDate.difference(_checkInDate).inDays} đêm'),
                          Text('${_totalPrice.toStringAsFixed(0)} đ'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tổng cộng',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${_totalPrice.toStringAsFixed(0)} đ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Book button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Xác nhận đặt phòng',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
