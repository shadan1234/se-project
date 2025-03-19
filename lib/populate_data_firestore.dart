import 'package:cloud_firestore/cloud_firestore.dart';

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

}
