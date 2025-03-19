import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se_project/common/textfield.dart';
import 'package:se_project/constants/colors.dart';
import 'package:se_project/features/admin/general-screen-admin.dart';
import 'package:se_project/features/auth/services/auth-service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se_project/features/customer/general-screen.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/signin';
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // Initialize AuthService
  bool isLoading = false;

  void navigateBasedOnRole(BuildContext context, User user) async {
  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  String role = userDoc['role'];
  
  if (role == "admin") {
    Navigator.pushReplacementNamed(context, AdminScreen.routeName);
  } else {
    Navigator.pushReplacementNamed(context, GeneralScreen.routeName);
  }
}


  // Function to handle sign-in
  void _handleSignIn() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Please enter email and password");
      setState(() => isLoading = false);
      return;
    }

    User? user = await _authService.loginWithEmail(context,email, password);
    
    if (user != null) {
      _showSnackBar("Sign-in successful!");
        navigateBasedOnRole(context, user);
    } else {
      _showSnackBar("Invalid credentials. Please try again.");
    }

    setState(() {
      isLoading = false;
    });
  }

  // Snackbar function for showing messages
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( resizeToAvoidBottomInset: false,
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

            Icon(Icons.lock_outline, size: 80, color: AppColors.accent),
            const SizedBox(height: 20),

            Text("Sign In",
                style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Text("Welcome back! Please enter your details",
                style: TextStyle(color: AppColors.secondaryText),
                textAlign: TextAlign.center),
            const SizedBox(height: 40),

            // Email Input
            CustomInputField(
              hintText: "Email Address",
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),

            // Password Input
            CustomInputField(
              hintText: "Password",
              icon: Icons.lock,
              isPassword: true,
              controller: passwordController,
            ),

            const SizedBox(height: 20),

            // Sign In Button
            isLoading
                ? CircularProgressIndicator(color: AppColors.accent) // Show loader while signing in
                : _buildButton(context, "Sign In", AppColors.accent, _handleSignIn),

            // Forgot Password
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot-password');
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(color: AppColors.accent, fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: TextStyle(color: AppColors.secondaryText)),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text("Sign Up", style: TextStyle(color: AppColors.accent)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color, VoidCallback onPressed) {
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
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
