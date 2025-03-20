import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se_project/firestore_updation.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentContact;
  final String currentEmail;
  final String currentImageUrl; // User's current profile image

  EditProfileScreen({
    required this.currentName,
    required this.currentContact,
    required this.currentEmail,
    required this.currentImageUrl,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.currentName;
    contactController.text = widget.currentContact;
    emailController.text = widget.currentEmail;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      String fileName = "profile_${DateTime.now().millisecondsSinceEpoch}.jpg";
      Reference ref = FirebaseStorage.instance.ref().child('profile_images/$fileName');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Image Upload Error: $e");
      return null;
    }
  }

  void _saveProfile() async {
    setState(() {
      _isLoading = true;
    });

    String? imageUrl = widget.currentImageUrl;

    if (_selectedImage != null) {
      String? uploadedUrl = await _uploadImage(File(_selectedImage!.path));
      if (uploadedUrl != null) {
        imageUrl = uploadedUrl;
      }
    }

    await FirestoreService().updateUserProfile(
      context,
      name: nameController.text.trim(),
      contact: contactController.text.trim(),
      email: emailController.text.trim(),
      imageUrl: imageUrl,
    );

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile Updated!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _selectedImage != null
                        ? FileImage(File(_selectedImage!.path))
                        : (widget.currentImageUrl.isNotEmpty
                            ? NetworkImage(widget.currentImageUrl) as ImageProvider
                            : AssetImage("assets/shad.jpg")),
                  ),
                  SizedBox(height: 8),
                  Text("Edit Profile Picture", style: TextStyle(color: Colors.blue, fontSize: 14)),
                ],
              ),
            ),
            SizedBox(height: 20),

            _buildTextField("Full Name", nameController),
            _buildTextField("Contact Number", contactController, keyboardType: TextInputType.phone),
            _buildTextField("Email Address", emailController, keyboardType: TextInputType.emailAddress),

            SizedBox(height: 20),

            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("Save Changes", style: TextStyle(fontSize: 16)),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }
}
