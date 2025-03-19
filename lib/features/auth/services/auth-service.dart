import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:se_project/features/provider/user_provider.dart';
import 'package:se_project/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream to listen to authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign Up with Email & Password & Store User Data
  Future<User?> signUpWithEmail(BuildContext context, name, String email, String password, String contactNo) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Store additional user info in Firestore
        await _firestore.collection("users").doc(user.uid).set({
          'name': name,
          'email': email,
          'contactNo': contactNo,
          'uid': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
          'role':'customer'
        });
      }
     DocumentSnapshot userDoc = await _firestore.collection("users").doc(user!.uid).get();
      UserModel userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.users= userModel; // Store properly
      return user;
    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  // Login with Email & Password
  Future<User?> loginWithEmail(BuildContext context, email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
        User? user = userCredential.user;

    if (user != null) {
      // Fetch user details from Firestore
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(user.uid).get();
      UserModel userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.users = userModel;
    }
    return user;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // User canceled sign-in

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await _auth.signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(user.uid).get();

      if (!userDoc.exists) {
        // If new user, store details
        await _firestore.collection("users").doc(user.uid).set({
          'name': user.displayName ?? "New User",
          'email': user.email,
          'contactNo': "",
          'uid': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
          'role': 'customer',
        });
      }

      // Fetch the stored user data
      userDoc = await _firestore.collection("users").doc(user.uid).get();
      UserModel userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.users = userModel;
    }
    return user;
  } catch (e) {
    print("Google Sign-In Error: $e");
    return null;
  }
}


  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
