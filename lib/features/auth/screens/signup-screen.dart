import 'package:flutter/material.dart';
import 'package:se_project/common/textfield.dart';
import 'package:se_project/constants/colors.dart';
import 'package:se_project/constants/text-styles.dart';
import 'package:se_project/features/auth/services/auth-service.dart';
import 'package:se_project/features/customer/general-screen.dart';


class SignUpScreen extends StatefulWidget {
  static const String routeName = "/signup";
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _authService = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    final user = await _authService.signUpWithEmail(context,name, email, password, phone);
    
    if (user != null) {
      Navigator.pushReplacementNamed(context, GeneralScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup failed. Please try again.")),
      );
    }

    setState(() => isLoading = false);
  }

  void signUpWithGoogle() async {
    setState(() => isLoading = true);
    
    final user = await _authService.signInWithGoogle(context);

    if (user != null) {
      Navigator.pushReplacementNamed(context, GeneralScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google Sign-In failed.")),
      );
    }

    setState(() => isLoading = false);
  }

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
            colors: [AppColors.primary, AppColors.darkPrimary],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Icon(Icons.person_add, size: 80, color: AppColors.accent),
              const SizedBox(height: 20),

              Text("Create Account", style: AppTextStyles.authTitle.copyWith(color: AppColors.accent)),
              const SizedBox(height: 10),
              Text("Join us and explore new possibilities",
                  style: AppTextStyles.authSubtitle.copyWith(color: AppColors.secondaryText),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInputField(
                      hintText: "Full Name",
                      icon: Icons.person,
                      controller: nameController,
                      validator: (value) => value!.isEmpty ? "Enter your name" : null,
                    ),
                    CustomInputField(
                      hintText: "Email Address",
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) => value!.contains("@") ? null : "Enter a valid email",
                    ),
                    CustomInputField(
                      hintText: "Contact Number",
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      validator: (value) => value!.length == 10 ? null : "Enter a valid 10-digit number",
                    ),
                    CustomInputField(
                      hintText: "Password",
                      icon: Icons.lock,
                      isPassword: true,
                      controller: passwordController,
                      validator: (value) => value!.length >= 6 ? null : "Password must be 6+ chars",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : _buildButton(context, "Sign Up", AppColors.secondary, signUp),
              _buildOutlinedButton(context, "Back to Sign In", '/signin'),

              const SizedBox(height: 20),
              Text("Or Sign Up with", style: AppTextStyles.authSubtitle.copyWith(color: AppColors.secondaryText)),
              const SizedBox(height: 10),
              isLoading ? const CircularProgressIndicator() : _buildGoogleButton(),
              const SizedBox(height: 40),
            ],
          ),
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
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4))],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

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
        onPressed: () => Navigator.pushNamed(context, route),
        child: Text(
          text,
          style: TextStyle(color: AppColors.accent, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4))],
      ),
      child: TextButton(
        onPressed: signUpWithGoogle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.g_translate, color: AppColors.primary),
            const SizedBox(width: 10),
            Text(
              "Sign Up with Google",
              style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
