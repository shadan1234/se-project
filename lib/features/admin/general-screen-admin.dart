import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';
import 'package:se_project/features/admin/admin-dashobard/admin-dashboard-screen.dart';
import 'package:se_project/features/admin/manage-rooms/manage-rooms-screen.dart';
import 'package:se_project/features/admin/manage-staff/manage-staff-screen.dart';
import 'package:se_project/features/admin/reports/reports-screen.dart';


class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    AdminDashboardScreen(),
    ManageRoomsScreen(),
    ManageStaffScreen(),
    ReportsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondaryText,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: 'Rooms'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Staff'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
        ],
      ),
    );
  }
}
