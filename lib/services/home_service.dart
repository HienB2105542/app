import 'dart:io';

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
    } else if (record.data.containsKey('imageUrl') &&
        record.data['imageUrl'].isNotEmpty) {
      return record.data['imageUrl'];
    }
    return ''; // Trả về rỗng nếu không có ảnh
  }

  Future<bool> createHomestay(Homestay homestay, {File? featuredImage}) async {
    try {
      final formData = {
        'name': homestay.name,
        'description': homestay.description,
        'location': homestay.location,
        'guests': homestay.guests,
        'rooms': homestay.rooms,
        'price': homestay.price,
        'isFavorite': homestay.isFavorite,
      };

      // Nếu có ảnh, tải ảnh lên
      if (featuredImage != null) {
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('${pb.baseUrl}/api/collections/homestays/records'),
        );

        // Thêm các trường dữ liệu
        formData.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        featuredImage.path.split('.').last.toLowerCase();

        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            featuredImage.path,
          ),
        );

        // Thêm header xác thực nếu cần
        if (pb.authStore.isValid) {
          request.headers['Authorization'] = 'Bearer ${pb.authStore.token}';
        }

        // Gửi request
        final response = await request.send();

        return response.statusCode >= 200 && response.statusCode < 300;
      } else if (homestay.imageUrl.isNotEmpty) {
        // Nếu có imageUrl (từ assets hoặc URL khác)
        formData['imageUrl'] = homestay.imageUrl;
        await pb.collection('homestays').create(body: formData);
        return true;
      } else {
        // Không có ảnh
        await pb.collection('homestays').create(body: formData);
        return true;
      }
    } catch (e) {
      print("Lỗi khi tạo homestay: $e");
      return false;
    }
  }
}
