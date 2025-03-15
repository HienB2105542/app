import 'dart:io';

class Homestay {
  final String? id;
  final String name;
  final String description;
  final String location;
  final int guests;
  final int rooms;
  final double price;
  final File? featuredImage;
  final String imageUrl;
  final bool isFavorite;

  Homestay({
    this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.guests,
    required this.rooms,
    required this.price,
    this.featuredImage,
    this.imageUrl = '',
    this.isFavorite = false,
  });

 Homestay copyWith({
    String? id,
    String? name,
    String? description,
    String? location,
    int? guests,
    int? rooms,
    double? price,
    File? featuredImage,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Homestay(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      guests: guests ?? this.guests,
      rooms: rooms ?? this.rooms,
      price: price ?? this.price,
      featuredImage: featuredImage ?? this.featuredImage,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  bool hasFeaturedImage() {
    return featuredImage != null || imageUrl.isNotEmpty;
  }

  // Chuyển đổi Homestay thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'guests': guests,
      'rooms': rooms,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }

  // Chuyển đổi từ JSON sang Homestay
factory Homestay.fromJson(Map<String, dynamic> json) {
    String baseUrl = "http://10.0.2.2:8090/api/files/";

    return Homestay(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      guests: json['guests'] ?? 0,
      rooms: json['rooms'] ?? 0,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image'] != null && json['image'].isNotEmpty
          ? "$baseUrl${json['collectionId']}/${json['id']}/${json['image']}"
          : '',
      isFavorite: json['isFavorite'] ?? false, description: '',
    );
  }
}
