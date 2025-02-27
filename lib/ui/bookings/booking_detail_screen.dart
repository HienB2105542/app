// import 'package:flutter/material.dart';
// import '../../models/booking.dart';
// import 'booking_manager.dart';
// import 'package:provider/provider.dart';

// class BookingDetailScreen extends StatelessWidget {
//   final Booking booking;

//   const BookingDetailScreen({super.key, required this.booking});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chi tiết đặt phòng'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Booking information card
//             Card(
//               margin: const EdgeInsets.only(bottom: 20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.house, color: Colors.redAccent),
//                         const SizedBox(width: 8),
//                         Text(
//                           booking.homestayName,
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Divider(height: 24),
//                     _buildInfoRow(Icons.person, 'Khách hàng', booking.userName),
//                     const SizedBox(height: 12),
//                     _buildInfoRow(
//                       Icons.calendar_today,
//                       'Ngày nhận phòng',
//                       '${booking.checkIn.day}/${booking.checkIn.month}/${booking.checkIn.year}',
//                     ),
//                     const SizedBox(height: 12),
//                     _buildInfoRow(
//                       Icons.calendar_today,
//                       'Ngày trả phòng',
//                       '${booking.checkOut.day}/${booking.checkOut.month}/${booking.checkOut.year}',
//                     ),
//                     const SizedBox(height: 12),
//                     _buildInfoRow(
//                       Icons.timelapse,
//                       'Số đêm',
//                       '${booking.checkOut.difference(booking.checkIn).inDays} đêm',
//                     ),
//                     const Divider(height: 24),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Tổng tiền',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           '${booking.totalPrice.toStringAsFixed(0)} đ',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.redAccent,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Status section
//             Card(
//               margin: const EdgeInsets.only(bottom: 20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Trạng thái đặt phòng',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.green,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: const Text(
//                             'Đã xác nhận',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const Spacer(),

//             // Cancel button
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   _showCancelDialog(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                 ),
//                 child: const Text(
//                   'Hủy đặt phòng',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(IconData icon, String label, String value) {
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: Colors.grey),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 label,
//                 style: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 14,
//                 ),
//               ),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _showCancelDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Xác nhận hủy'),
//         content: const Text('Bạn có chắc chắn muốn hủy đặt phòng này không?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//             child: const Text('Không'),
//           ),
//           TextButton(
//             onPressed: () {
//               // Cancel the booking
//               final bookingManager =
//                   Provider.of<BookingManager>(context, listen: false);
//               bookingManager.removeBooking(booking.id);

//               // Navigate back to bookings screen
//               Navigator.of(ctx).pop();
//               Navigator.of(context).pop();

//               // Show success message
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Đã hủy đặt phòng thành công!'),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             },
//             child: const Text('Có, hủy đặt phòng'),
//           ),
//         ],
//       ),
//     );
//   }
// }
