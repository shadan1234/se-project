class Room {
  final String id;
  final int roomNumber;
  final String type;
  final int pricePerNight;
  final String status;
  final int capacity;
  final String imageUrl;
  final List<String> facilities;

  Room({
    required this.id,
    required this.roomNumber,
    required this.type,
    required this.pricePerNight,
    required this.status,
    required this.capacity,
    required this.imageUrl,
    required this.facilities,
  });

  factory Room.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Room(
      id: documentId,
      roomNumber: data['roomNumber'],
      type: data['type'],
      pricePerNight: data['pricePerNight'],
      status: data['status'],
      capacity: data['capacity'],
      imageUrl: data['imageUrl'],
      facilities: List<String>.from(data['facilities']),
    );
  }
}
