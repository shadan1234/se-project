import 'package:flutter/material.dart';
import 'package:se_project/common/textfield.dart';
import 'package:se_project/constants/colors.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName='/signin';
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            Icon(Icons.lock_outline, size: 80, color: AppColors.accent),
            const SizedBox(height: 20),

            // Title Text
            Text("Sign In",
                style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Subtitle
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
            _buildButton(context, "Sign In", AppColors.accent, () {
              // Handle sign-in logic here
              print("Email: ${emailController.text}");
              print("Password: ${passwordController.text}");
            }),

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
