import 'package:flutter/material.dart';
import 'package:se_project/firestore_updation.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = "add-room-screen";

  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String _selectedType = "Deluxe";
  int _selectedCapacity = 2;

  // Upload Room to Firestore
  Future<void> _uploadRoom() async {
    if (!_formKey.currentState!.validate()) return;

    await _firestoreService.addRoom(
      roomNumber: int.parse(_roomNumberController.text),
      type: _selectedType,
      pricePerNight: int.parse(_priceController.text),
      status: "Available",
      capacity: _selectedCapacity,
      imageUrl: "", // Placeholder, will be updated later
      facilities: ["WiFi", "TV", "AC"], // Can be modified dynamically later
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Room Added Successfully!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Room")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Room Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),

                // Room Number
                TextFormField(
                  controller: _roomNumberController,
                  decoration: InputDecoration(labelText: "Room Number", border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Enter room number" : null,
                ),
                SizedBox(height: 16),

                // Price
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: "Price per Night", border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Enter price per night" : null,
                ),
                SizedBox(height: 16),

                // Room Type Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  decoration: InputDecoration(labelText: "Room Type", border: OutlineInputBorder()),
                  items: ["Deluxe", "Standard", "Suite"].map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedType = value!),
                ),
                SizedBox(height: 16),

                // Capacity Dropdown
                DropdownButtonFormField<int>(
                  value: _selectedCapacity,
                  decoration: InputDecoration(labelText: "Capacity", border: OutlineInputBorder()),
                  items: [1, 2, 3, 4, 5].map((capacity) {
                    return DropdownMenuItem(value: capacity, child: Text("$capacity Person(s)"));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedCapacity = value!),
                ),
                SizedBox(height: 20),

                // Upload Room Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _uploadRoom,
                    icon: Icon(Icons.cloud_upload),
                    label: Text("Upload Room", style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
