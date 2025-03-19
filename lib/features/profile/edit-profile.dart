import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se_project/firestore_updation.dart';
// import 'package:se_project/services/firestore_service.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentContact;
  EditProfileScreen({required this.currentContact});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController contactController = TextEditingController();
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    contactController.text = widget.currentContact;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  void _saveProfile() async {
    // Store only contact in Firestore (Image URL is handled separately)
    await FirestoreService().updateUserProfile(
         context,
      contact: contactController.text.trim(),
      imageUrl: _selectedImage != null ? "ADD_FIREBASE_IMAGE_URL_HERE" : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile Updated!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _selectedImage != null
                    ? FileImage(File(_selectedImage!.path))
                    : AssetImage("assets/shad.jpg") as ImageProvider,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: contactController,
              decoration: InputDecoration(labelText: "Update Contact Number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
