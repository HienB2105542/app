import 'dart:io';

import 'package:homestay/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';
import '../models/homestay.dart';

class HomeService {
  final PocketBase pb = PocketBase('http://10.0.2.2:8090');

  Future<List<Homestay>> getHomestays() async {
    try {
      final records = await pb.collection('homestays').getList();
      return records.items.map((record) {
        return Homestay(
            id: record.id,
            name: record.data['name'],
            description: record.data['description'],
            location: record.data['location'],
            imageUrl: getImageUrl(record),
            price: record.data['price'].toDouble(),
            rooms: record.data['rooms'],
            guests: record.data['guests']);
      }).toList();
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
      return [];
    }
  }

  String getImageUrl(RecordModel record) {
  if (record.data.containsKey('image') && record.data['image'].isNotEmpty) {
    return '${pb.baseUrl}/api/files/${record.collectionId}/${record.id}/${record.data['image']}';
  }
  return ''; // Trả về rỗng nếu không có ảnh
}


  Future<bool> createHomestay(Homestay homestay, {File? featuredImage}) async {
    try {
      final authService = AuthService();
      final userId = await authService.getUserId(); // Lấy userId hiện tại
      print("User ID lấy được: $userId");

      if (userId == null) {
        print("Lỗi: không tìm thấy userId, Vui lòng đăng nhập.");
        return false;
      }

      // Tạo form dữ liệu
      final formData = <String, dynamic>{
        'name': homestay.name,
        'description': homestay.description,
        'location': homestay.location,
        'guests': homestay.guests,
        'rooms': homestay.rooms,
        'price': homestay.price,
        'isFavorite': homestay.isFavorite,
        'userId': userId, // Lưu ID người dùng vào bài đăng
      };

      print("Dữ liệu gửi lên API: $formData");

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${pb.baseUrl}/api/collections/homestays/records'),
      );

      // Thêm các trường dữ liệu vào request
      formData.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Nếu có ảnh, thêm ảnh vào request
      if (featuredImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image', // Tên cột ảnh trên PocketBase
            featuredImage.path,
          ),
        );
      }

      // Thêm header xác thực nếu cần
      if (pb.authStore.isValid) {
        request.headers['Authorization'] = 'Bearer ${pb.authStore.token}';
      }

      // Gửi request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print("Phản hồi từ PocketBase: $responseBody");

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      print("Lỗi khi tạo homestay: $e");
      return false;
    }
  }
}