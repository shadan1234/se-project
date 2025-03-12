import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';
import 'package:se_project/features/auth/screens/auth-main-screen.dart';
import 'package:se_project/features/auth/screens/signup-screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          // Profile Header
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/shad.jpg"), // Ensure you have this image
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Shadan Hussain",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "shadan@gmail.com",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          // Profile Options
          _buildProfileOption(Icons.edit, "Edit Profile", () {}),
          _buildProfileOption(Icons.history, "Booking History", () {}),
          _buildProfileOption(Icons.settings, "Settings", () {}),
          _buildProfileOption(Icons.logout, "Logout", () {
            Navigator.popAndPushNamed(context, SignUpScreen.routeName );
          }),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: 30),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}