import 'package:flutter/material.dart';
import 'package:se_project/models/room_model.dart';
import 'package:se_project/firestore_updation.dart';

class ModifyRoomScreen extends StatefulWidget {
  final Room room;

  ModifyRoomScreen({required this.room});

  @override
  _ModifyRoomScreenState createState() => _ModifyRoomScreenState();
}

class _ModifyRoomScreenState extends State<ModifyRoomScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _priceController;
  late int _selectedCapacity;
  late String _selectedType;
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(text: widget.room.pricePerNight.toString());
    _selectedCapacity = widget.room.capacity;
    _selectedType = widget.room.type;
    _selectedStatus = widget.room.status;
  }

  // Update Room in Firestore
  Future<void> _updateRoom() async {
    if (!_formKey.currentState!.validate()) return;

    await _firestoreService.updateRoom(
      roomId: widget.room.id, // Unique room ID
      updatedData: {
        "pricePerNight": int.parse(_priceController.text),
        "capacity": _selectedCapacity,
        "type": _selectedType,
        "status": _selectedStatus,
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Room Updated Successfully!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modify Room")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Modify Room Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),

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
                SizedBox(height: 16),

                // Room Status Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: InputDecoration(labelText: "Room Status", border: OutlineInputBorder()),
                  items: ["Available", "Booked", "Under Maintenance"].map((status) {
                    return DropdownMenuItem(value: status, child: Text(status));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedStatus = value!),
                ),
                SizedBox(height: 20),

                // Update Room Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _updateRoom,
                    icon: Icon(Icons.save),
                    label: Text("Update Room", style: TextStyle(fontSize: 16)),
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
