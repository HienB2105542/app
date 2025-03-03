import 'package:flutter/material.dart';
import 'package:homestay/models/homestay.dart';
import 'home_manager.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _selectedImage = "assets/images/dalat.jpg"; // Default image

  final List<String> _availableImages = [
    "assets/images/dalat.jpg",
    "assets/images/hanoi.jpg",
    "assets/images/laocai.jpg",
    "assets/images/nhatrang.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng tin Homestay"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Thông tin Homestay",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Tên Homestay",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.house),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập tên Homestay";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: "Địa điểm",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập địa điểm";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _guestsController,
                decoration: const InputDecoration(
                  labelText: "Số khách (VD: 2 khách, 1 phòng ngủ)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập thông tin số khách";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: "Giá (VD: 1.200.000 VND/đêm)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monetization_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập giá Homestay";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Chọn hình ảnh",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableImages.length,
                  itemBuilder: (context, index) {
                    final image = _availableImages[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImage = image;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedImage == image
                                ? Colors.redAccent
                                : Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: Image.asset(
                          image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitHomestay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text(
                    "Đăng tin",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitHomestay() {
    if (_formKey.currentState!.validate()) {
      final newHomestay = Homestay(
        id: DateTime.now().toString(), 
        name: _nameController.text,
        description: "Mô tả homestay", 
        location: _locationController.text,
        guests: int.tryParse(_guestsController.text) ?? 0,
        imageUrl: _selectedImage,
        price: double.tryParse(
                _priceController.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
            0, 
        rooms: 1, 
      );

      // Thêm vào danh sách homestays
      HomeManager().homestays.add(newHomestay);

      // Hiển thị thông báo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Đăng tin thành công!"),
          backgroundColor: Colors.green,
        ),
      );

      // Quay lại màn hình trước
      Navigator.pop(context);
    }
  }


  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _guestsController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
