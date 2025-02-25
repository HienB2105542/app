class Homestay {
  final String id;
  final String name;
  final String description;
  final String location;
  final String guests;
  final String imageUrl;
  final double price;
  final int rooms;

  const Homestay({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.guests,
    required this.imageUrl,
    required this.price,
    required this.rooms,
  });
}
