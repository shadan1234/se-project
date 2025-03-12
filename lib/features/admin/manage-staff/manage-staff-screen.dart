import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';

class ManageStaffScreen extends StatelessWidget {
  final List<Map<String, String>> staff = [
    {"name": "John Doe", "role": "Manager", "contact": "9876543210"},
    {"name": "Alice Smith", "role": "Receptionist", "contact": "8765432109"},
    {"name": "Michael Brown", "role": "Housekeeping", "contact": "7654321098"},
    {"name": "Sarah Johnson", "role": "Chef", "contact": "6543210987"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Manage Staff", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Staff Members", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: staff.length,
                itemBuilder: (context, index) {
                  final member = staff[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(Icons.person, color: AppColors.primary),
                      title: Text(member['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text("Role: ${member['role']} • Contact: ${member['contact']}"),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // Edit staff functionality
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Delete staff functionality
                            },
                          ),
                        ],
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
                // Add new staff functionality
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text("Add New Staff", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
