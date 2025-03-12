import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';

class ManageRoomsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> rooms = [
    {"number": "101", "status": "Available", "price": "\$100/night"},
    {"number": "102", "status": "Occupied", "price": "\$120/night"},
    {"number": "201", "status": "Available", "price": "\$90/night"},
    {"number": "305", "status": "Under Maintenance", "price": "-"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Manage Rooms", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Room List", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(Icons.meeting_room, color: AppColors.primary),
                      title: Text("Room ${room['number']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text("Status: ${room['status']} • Price: ${room['price']}"),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Edit Room Functionality
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Add Room Functionality
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text("Add New Room", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
