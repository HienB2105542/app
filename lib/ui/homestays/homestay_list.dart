// import 'package:flutter/material.dart';
// import 'detail_screen.dart';

// class HomestayListScreen extends StatelessWidget {
//   final List<Map<String, String>> homestays = [
//     {
//       "name": "Homestay Đà Lạt",
//       "location": "Đà Lạt, Lâm Đồng",
//       "guests": "4 khách",
//       "price": "1.200.000 VND/đêm",
//       "image": "assets/images/dalat.jpg"
//     },
//     {
//       "name": "Homestay Nha Trang",
//       "location": "Nha Trang, Khánh Hòa",
//       "guests": "2 khách",
//       "price": "900.000 VND/đêm",
//       "image": "assets/images/nhatrang.jpg"
//     },
//   ];

//   HomestayListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Danh sách Homestay"),
//         backgroundColor: Colors.redAccent,
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         itemCount: homestays.length,
//         itemBuilder: (context, index) {
//           final homestay = homestays[index];
//           return Card(
//             margin: const EdgeInsets.all(10),
//             child: ListTile(
//               leading:
//                   Image.asset(homestay["image"]!, width: 80, fit: BoxFit.cover),
//               title: Text(homestay["name"]!,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold)),
//               subtitle:
//                   Text("${homestay["location"]!} • ${homestay["price"]!}"),
//               trailing:
//                   const Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => DetailScreen(homestay: homestay),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
