import 'package:flutter/material.dart';

import 'package:se_project/constants/colors.dart';
import 'package:se_project/features/customer/booking/booking-screen.dart';
import 'package:se_project/features/customer/home/home-screen.dart';
import 'package:se_project/features/customer/services/services-screen.dart';
import 'package:se_project/features/profile/profile-screen.dart';

class GeneralScreen extends StatefulWidget {
  static const String routeName='/general-screen';
  @override
  _GeneralScreenState createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    CustomerHomeScreen(),
    BookingScreen(),
    ServicesScreen(),
    ProfileScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.room_service), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
