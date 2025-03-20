import 'package:cloud_firestore/cloud_firestore.dart';

class AdminFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch total bookings count
  Future<int> getTotalBookings() async {
    QuerySnapshot snapshot = await _db.collection('bookings').get();
    return snapshot.size;
  }

  // Fetch available rooms count
  Future<int> getAvailableRooms() async {
    QuerySnapshot snapshot = await _db.collection('rooms').where('status', isEqualTo: 'Available').get();
    return snapshot.size;
  }

  // Fetch total revenue (sum of all bookings' pricePerNight)
  Future<double> getTotalRevenue() async {
    QuerySnapshot snapshot = await _db.collection('bookings').get();
    double totalRevenue = 0;
    for (var doc in snapshot.docs) {
      totalRevenue += (doc['pricePerNight'] as num).toDouble();
    }
    return totalRevenue;
  }

  // Fetch total staff count
  Future<int> getTotalStaff() async {
    QuerySnapshot snapshot = await _db.collection('users').where('role', isEqualTo: 'staff').get();
    return snapshot.size;
  }

  // Fetch recent activities (latest 5 bookings)
Future<List<String>> getRecentActivities() async {
  QuerySnapshot bookingSnapshot = await _db
      .collection('bookings')
      .orderBy('checkInDate', descending: true)
      .limit(5)
      .get();

  List<String> activities = [];

  for (var bookingDoc in bookingSnapshot.docs) {
    String userId = bookingDoc['userId'];
    String roomNumber = bookingDoc['roomNumber'].toString();

    // Fetch userName from users collection using userId
    DocumentSnapshot userSnapshot = await _db.collection('users').doc(userId).get();
    String userName = userSnapshot.exists ? userSnapshot['name'] : "Unknown User";

    activities.add("Room $roomNumber booked by $userName");
  }

  return activities;
}
}
