class UserModel {
  final String uid;
  final String name;
  final String email;
  final String contactNo;
  final String role;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.contactNo,
    required this.role,
  });

  // Convert Firestore data to UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      contactNo: map['contactNo'] ?? '',
      role: map['role'] ?? 'customer',
    );
  }

  // Convert UserModel to Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'contactNo': contactNo,
      'role': role,
    };
  }
}
