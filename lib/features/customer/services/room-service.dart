import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se_project/models/room_model.dart';

class RoomService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Room>> getRooms() {
    return _db.collection("rooms").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Room.fromFirestore(doc.data(), doc.id)).toList());
  }
}
