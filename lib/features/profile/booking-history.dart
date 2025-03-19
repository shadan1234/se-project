import 'package:flutter/material.dart';
import 'package:se_project/firestore_updation.dart';
// import 'package:se_project/services/firestore_service.dart';

class RoomBookingHistoryScreen extends StatefulWidget {
  final String userId; // Pass current logged-in user ID

  RoomBookingHistoryScreen({required this.userId});

  @override
  _RoomBookingHistoryScreenState createState() => _RoomBookingHistoryScreenState();
}

class _RoomBookingHistoryScreenState extends State<RoomBookingHistoryScreen> {
  late Future<List<Map<String, dynamic>>> _bookingHistory;

  @override
  void initState() {
    super.initState();
    _bookingHistory = FirestoreService().fetchBookingHistory(context);
  }

  @override
  Widget build(BuildContext context) {
    print('bale');
    print(_bookingHistory);
   _bookingHistory.then((bookings) {
  for (var x in bookings) {
    print(x);
  }
});
 print("baleewe");
    return Scaffold(
      appBar: AppBar(title: Text("Room Booking History")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bookingHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No room bookings found."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final booking = snapshot.data![index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Room No: ${booking['roomNumber']}", 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Room ID: ${booking['roomId']}", style: TextStyle(color: Colors.grey[700])),
                      SizedBox(height: 5),
                      Text("Check-in: ${booking['checkInDate']}"),
                      Text("Check-out: ${booking['checkOutDate']}"),
                      SizedBox(height: 5),
                      Text("Price per Night: ₹${booking['pricePerNight']}", 
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Status: ${booking['status']}", 
                          style: TextStyle(color: booking['status'] == 'Confirmed' ? Colors.green : Colors.red)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
