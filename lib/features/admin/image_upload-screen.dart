import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminImageUploadScreen extends StatefulWidget {
  static const String routeName='/image-upload-screen';
  @override
  _AdminImageUploadScreenState createState() => _AdminImageUploadScreenState();
}

class _AdminImageUploadScreenState extends State<AdminImageUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Pick Image from Gallery or Camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Image")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!, height: 150) // Show selected image
                : Text("No Image Selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pick Image"),
            ),
          ],
        ),
      ),
    );
  }
}
