import 'package:pocketbase/pocketbase.dart';
import '../models/homestay.dart';

class PocketBaseService {
  final PocketBase pb = PocketBase('http://10.0.0.2:8090');

  Future<List<Homestay>> getHomestays() async {
    try {
      final records = await pb.collection('homestays').getList();
      return records.items.map((record) {
        return Homestay(
            id: record.id,
            name: record.data['name'],
            description: record.data['description'],
            location: record.data['location'],
            imageUrl: record.data['imageUrl'],
            price: record.data['price'].toDouble(),
            rooms: record.data['rooms'],
            guests: record.data['guests']);
      }).toList();
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
      return [];
    }
  }
}
