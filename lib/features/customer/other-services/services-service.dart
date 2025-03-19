import 'package:cloud_firestore/cloud_firestore.dart';

class OtherService{
   final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('services-bookings');

  Future<void> bookService({
    required String serviceName,
    required String customerName,
    required String contact,
    required String date,
    required String additionalDetails,
  }) async {
    try {
      await bookingCollection.add({
        'serviceName': serviceName,
        'customerName': customerName,
        'contact': contact,
        'date': date,
        'additionalDetails': additionalDetails,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error booking service: $e");
      throw e;
    }
  }
}