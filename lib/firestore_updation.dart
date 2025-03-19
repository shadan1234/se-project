import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/features/provider/user_provider.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addRoom({
    required int roomNumber,
    required String type,
    required int pricePerNight,
    required String status,
    required int capacity,
    required String imageUrl,
    required List<String> facilities,
  }) async {
    await _db.collection("rooms").add({
      "roomNumber": roomNumber,
      "type": type,
      "pricePerNight": pricePerNight,
      "status": status,
      "capacity": capacity,
      "imageUrl": imageUrl,
      "facilities": facilities,
    });
  }

  Future<void> updateRoom({required String roomId, required Map<String, dynamic> updatedData}) async {
  try {
    await FirebaseFirestore.instance.collection("rooms").doc(roomId).update(updatedData);
  } catch (e) {
    print("Error updating room: $e");
    throw e;
  }
}
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserProfile(BuildContext context,{String ? contact, String? imageUrl}) async {
    final UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);
    final user=userProvider.users;
    String userId = user!.uid; // Replace with logged-in user ID
    try {
      await users.doc(userId).update({
        if (contact != null) 'contact': contact,
        if (imageUrl != null) 'profilePic': imageUrl,
      });
    } catch (e) {
      print("Error updating profile: $e");
    }
  }


Future<List<Map<String, dynamic>>> fetchBookingHistory(BuildContext context) async {
  try {
    final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    String userId = userProvider.users!.uid;

    print("Fetching booking history for userId: $userId");

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('bookings') // Collection name
        .where('userId', isEqualTo: userId) // Filter by userId
        .orderBy('checkInDate', descending: true) // Order by latest bookings
        .get();

    if (snapshot.docs.isEmpty) {
      print("No bookings found for userId: $userId");
    } else {
      print("Fetched ${snapshot.docs.length} bookings:");
      for (var doc in snapshot.docs) {
        print(doc.data());
      }
    }

    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  } catch (e) {
    print("🔥 Error fetching booking history: $e");
    return [];
  }
}


}
