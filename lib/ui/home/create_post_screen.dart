import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:homestay/models/homestay.dart';

import '../../services/home_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController();
  final TextEditingController _roomsController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  File? _selectedFile;
  bool _useAssetImage = true;
  bool _isLoading = false;

  final HomeService _homeService = HomeService();
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        _useAssetImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng tin Homestay"),
        backgroundColor: Colors.redAccent,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Thông tin Homestay",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Mô tả",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập mô tả";
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
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _guestsController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Số khách",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.people),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vui lòng nhập số khách";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _roomsController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Số phòng",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.hotel),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vui lòng nhập số phòng";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
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
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        _selectedFile != null
                            ? Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Image.file(
                                      _selectedFile!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        _selectedFile = null;
                                        _useAssetImage = false;
                                      });
                                    },
                                  ),
                                ],
                              )
                            : Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.image,
                                        size: 50, color: Colors.grey),
                                    const SizedBox(height: 10),
                                    ElevatedButton.icon(
                                      onPressed: _pickImage,
                                      icon:
                                          const Icon(Icons.add_photo_alternate),
                                      label: const Text("Chọn ảnh"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
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

  // void _submitHomestay() {
  //   if (_formKey.currentState!.validate()) {
  //     final newHomestay = Homestay(
  //       id: DateTime.now().toString(),
  //       name: _nameController.text,
  //       description: "Mô tả homestay",
  //       location: _locationController.text,
  //       guests: int.tryParse(_guestsController.text) ?? 0,
  //       imageUrl: _selectedImage,
  //       price: double.tryParse(
  //               _priceController.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
  //           0,
  //       rooms: 1,
  //     );

  //     // Thêm vào danh sách homestays
  //     HomeManager().homestays.add(newHomestay);

  //     // Hiển thị thông báo
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Đăng tin thành công!"),
  //         backgroundColor: Colors.green,
  //       ),
  //     );

  //     // Quay lại màn hình trước
  //     Navigator.pop(context);
  //   }
  // }
  void _submitHomestay() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Tạo homestay mới
      final newHomestay = Homestay(
        name: _nameController.text,
        description: _descriptionController.text,
        location: _locationController.text,
        guests: int.tryParse(_guestsController.text) ?? 2,
        rooms: int.tryParse(_roomsController.text) ?? 1,
        imageUrl: _selectedFile != null ? _selectedFile!.path : '',
        price: double.tryParse(
                _priceController.text.replaceAll(RegExp(r'[^0-9.]'), '')) ??
            0,
      );

      try {
        // Lưu homestay vào PocketBase
        final success = await _homeService.createHomestay(newHomestay,
            featuredImage: _selectedFile);

        setState(() {
          _isLoading = false;
        });

        if (success) {
          // Hiển thị thông báo
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Đăng tin thành công!"),
              backgroundColor: Colors.green,
            ),
          );

          // Quay lại màn hình trước
          Navigator.pop(context);
        } else {
          // Hiển thị thông báo lỗi
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Đăng tin thất bại. Vui lòng thử lại!"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Hiển thị thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Lỗi: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _guestsController.dispose();
    _roomsController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
