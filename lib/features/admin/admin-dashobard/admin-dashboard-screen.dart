import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';
import 'package:se_project/features/admin/admin-firestore-service.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final AdminFirestoreService _adminService = AdminFirestoreService();

  late Future<int> _totalBookings;
  late Future<int> _availableRooms;
  late Future<double> _totalRevenue;
  late Future<int> _totalStaff;
  late Future<List<String>> _recentActivities;

  @override
  void initState() {
    super.initState();
    _totalBookings = _adminService.getTotalBookings();
    _availableRooms = _adminService.getAvailableRooms();
    _totalRevenue = _adminService.getTotalRevenue();
    _totalStaff = _adminService.getTotalStaff();
    _recentActivities = _adminService.getRecentActivities();
  }

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

            // Stats Cards - Fetching Data Dynamically
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildStatCard("Total Bookings", _totalBookings, Icons.book_online, Colors.blue),
                _buildStatCard("Available Rooms", _availableRooms, Icons.hotel, Colors.green),
                _buildStatCard("Revenue", _totalRevenue, Icons.attach_money, Colors.orange, isMoney: true),
                _buildStatCard("Total Staff", _totalStaff, Icons.people, Colors.red),
              ],
            ),

            SizedBox(height: 24),
            Text("Recent Activity", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 8),

            Expanded(
              child: FutureBuilder<List<String>>(
                future: _recentActivities,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No recent activities."));
                  }

                  return ListView(
                    children: snapshot.data!.map((activity) => _buildRecentActivity(activity, Icons.check_circle, Colors.green)).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dynamic Stat Card with FutureBuilder
  Widget _buildStatCard(String title, Future<dynamic> futureValue, IconData icon, Color color, {bool isMoney = false}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<dynamic>(
          future: futureValue,
          builder: (context, snapshot) {
            String displayValue = snapshot.hasData ? (isMoney ? "₹${snapshot.data}" : snapshot.data.toString()) : "...";
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: color),
                SizedBox(height: 8),
                Text(displayValue, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
                SizedBox(height: 4),
                Text(title, style: TextStyle(fontSize: 14, color: AppColors.secondaryText)),
              ],
            );
          },
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
