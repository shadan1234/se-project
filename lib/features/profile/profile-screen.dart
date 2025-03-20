import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/constants/colors.dart';
import 'package:se_project/features/auth/screens/auth-main-screen.dart';
import 'package:se_project/features/auth/screens/signup-screen.dart';
import 'package:se_project/features/auth/services/auth-service.dart';
import 'package:se_project/features/profile/booking-history.dart';
import 'package:se_project/features/profile/edit-profile.dart';
import 'package:se_project/provider/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.users;
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
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        "assets/shad.jpg"), // Ensure you have this image
                  ),
                  SizedBox(height: 10),
                  Text(
                    user!.name,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    user!.email,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          // Profile Options
          _buildProfileOption(Icons.edit, "Edit Profile", () {
            
            // print(user.name);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditProfileScreen(currentContact: user.contactNo , currentEmail: user.email,currentImageUrl: '' ,currentName: user.name,),
              ),
            );
          }),
          _buildProfileOption(Icons.history, "Booking History", () {
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RoomBookingHistoryScreen(userId: user.uid)),
  );
          }),
          _buildProfileOption(Icons.settings, "Settings", () {}),
          _buildProfileOption(Icons.logout, "Logout", () async{
 await _authService.signOut();
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => AuthMainScreen()),
    (route) => false,
  );
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
        title: Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
