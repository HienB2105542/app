import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/homestay.dart';
import '../../models/booking.dart';
import 'booking_manager.dart';
import '../../services/book_service.dart';

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
  double _totalPrice = 0;
  int _nights = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkInDate = DateTime.now().add(const Duration(days: 1));
    _checkOutDate = DateTime.now().add(const Duration(days: 2));
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    _nights = _checkOutDate.difference(_checkInDate).inDays;
    setState(() {
      _totalPrice = widget.homestay.price * _nights;
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

void _submitBooking() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      final userId = await BookService().getUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lỗi: Không lấy được thông tin người dùng'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return; 
      }

      final homestay = widget.homestay;

      final booking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        homestayId: homestay.id ?? '',
        homestayName: homestay.name,
        phone: '', 
        location: homestay.location,
        checkInDate: _checkInDate,
        checkOutDate: _checkOutDate,
        status: 'pending',
        nights: _nights,
        totalPrice: _totalPrice,
        userId: userId, 
      );

      final bookingManager =
          Provider.of<BookingManager>(context, listen: false);
      final success = await bookingManager.addBooking(booking);
      if (success) {
        await bookingManager.fetchBookings(userId); 
        Navigator.pushReplacementNamed(context, '/bookings'); 
      }

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success
              ? 'Đặt phòng thành công! Chờ duyệt'
              : 'Có lỗi xảy ra khi đặt phòng. Vui lòng thử lại sau.'),
          backgroundColor: success ? Colors.orange : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt phòng'),
        backgroundColor: Colors.redAccent,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
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

                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

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
                      },
                    ),

                    const SizedBox(height: 20),
                    
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Số điện thoại',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),

                    const SizedBox(height: 20),

                    ListTile(
                      title: const Text('Ngày nhận phòng'),
                      subtitle: Text(
                          '${_checkInDate.day}/${_checkInDate.month}/${_checkInDate.year}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectCheckInDate(context),
                    ),

                    const Divider(),

                    ListTile(
                      title: const Text('Ngày trả phòng'),
                      subtitle: Text(
                          '${_checkOutDate.day}/${_checkOutDate.month}/${_checkOutDate.year}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectCheckOutDate(context),
                    ),

                    const SizedBox(height: 20),

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
                                    '${widget.homestay.price.toStringAsFixed(0)} đ x $_nights đêm'),
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
