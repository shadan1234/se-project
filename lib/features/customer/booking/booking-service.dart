import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> bookRoom({
    required String roomId,
    required int roomNumber,
    required String roomType,
    required int pricePerNight,
    required int capacity,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required String paymentWay
  }) async {
    try {
      String userId = _auth.currentUser!.uid;  // Get logged-in user ID

      await _firestore.collection("bookings").add({
        "userId": userId,
        "roomId": roomId,
        "roomNumber": roomNumber,
        "roomType": roomType,
        "pricePerNight": pricePerNight,
        "capacity": capacity,
        "checkInDate": checkInDate.toIso8601String(),
        "checkOutDate": checkOutDate.toIso8601String(),
        "status": "pending", // Default status
        "timestamp": FieldValue.serverTimestamp(),
        "paymentWay": paymentWay
      });

      print("Booking Successful!");
    } catch (e) {
      print("Error Booking Room: $e");
    }
  }
}
