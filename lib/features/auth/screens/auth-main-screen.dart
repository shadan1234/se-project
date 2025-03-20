import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';
import 'package:se_project/constants/size_config.dart';
import 'package:se_project/constants/text-styles.dart';
import 'package:se_project/features/admin/add_room_screen.dart';
import 'package:se_project/features/admin/general-screen-admin.dart';
import 'package:se_project/features/admin/image_upload-screen.dart';
import 'package:se_project/features/auth/screens/signin-screen.dart';
import 'package:se_project/features/auth/screens/signup-screen.dart';
import 'package:se_project/features/customer/general-screen.dart';

class AuthMainScreen extends StatelessWidget {
static const String routeName = '/auth-main-screen';
  const AuthMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.darkPrimary, 
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            
            // App Icon or Logo
            Icon(Icons.shield, size: 80, color: AppColors.accent), 
            const SizedBox(height: 20),

            // Title Text
            Text("Welcome", style: AppTextStyles.authTitle.copyWith(color: AppColors.accent)),
            const SizedBox(height: 10),

            // Subtitle
            Text("Join us and explore new possibilities",
                style: AppTextStyles.authSubtitle.copyWith(color: AppColors.secondaryText),
                textAlign: TextAlign.center),
            const SizedBox(height: 40),

            // Buttons with updated colors
            _buildButton(context, "Sign Up", AppColors.secondary, SignUpScreen.routeName),   // Gold Button
            _buildButton(context, "Sign In", AppColors.accent, SignInScreen.routeName ),     // Soft White Button
            _buildOutlinedButton(context, "Enter as Guest",
            //  AdminScreen.routeName  
            GeneralScreen.routeName 
             ),          // Outlined Button

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // **Primary Button**
  Widget _buildButton(BuildContext context, String text, Color color, String route) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4))
        ],
      ),
      child: TextButton(
        child: Text(
          text, 
          style: TextStyle(
            color: color == AppColors.secondary ? AppColors.primary : AppColors.primary, 
            fontSize: 18, 
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: (){ 
          
          Navigator.pushNamed(context, route);
        }
      ),
    );
  }

  // **Outlined Button**
  Widget _buildOutlinedButton(BuildContext context, String text, String route) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent, width: 2),
      ),
      child: TextButton(
        child: Text(
          text, 
          style: TextStyle(
            color: AppColors.accent, 
            fontSize: 18, 
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () => Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => GeneralScreen()),
    (route) => false,  ),
      ),
    );
  }
}
