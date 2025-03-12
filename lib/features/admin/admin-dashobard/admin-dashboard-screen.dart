import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Admin Dashboard", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Overview", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 16),
            
            // Stats Cards
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildStatCard("Total Bookings", "120", Icons.book_online, Colors.blue),
                _buildStatCard("Available Rooms", "30", Icons.hotel, Colors.green),
                _buildStatCard("Revenue", "\$24K", Icons.attach_money, Colors.orange),
                _buildStatCard("Total Staff", "25", Icons.people, Colors.red),
              ],
            ),

            SizedBox(height: 24),
            Text("Recent Activity", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 8),

            Expanded(
              child: ListView(
                children: [
                  _buildRecentActivity("Room 101 booked by John Doe", Icons.check_circle, Colors.green),
                  _buildRecentActivity("Room 305 checkout completed", Icons.logout, Colors.red),
                  _buildRecentActivity("New staff added: Alice Williams", Icons.person_add, Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 14, color: AppColors.secondaryText)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(String text, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(text, style: TextStyle(color: AppColors.primary)),
      ),
    );
  }
}
