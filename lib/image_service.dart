import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  ImagePicker get _picker => ImagePicker();

  // Pick Image from Gallery
  Future<File?> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Upload Image to Firebase Storage
  Future<String?> uploadImage(File imageFile, String roomNumber) async {
    try {
      String fileName = "room_$roomNumber.jpg";
      Reference ref = _storage.ref().child("room_images/$fileName");
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }
}
