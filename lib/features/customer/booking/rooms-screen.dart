import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/features/admin/add_room_screen.dart';
import 'package:se_project/features/admin/modify_room.dart';
import 'package:se_project/features/customer/booking/room-booking.dart';
import 'package:se_project/features/customer/services/room-service.dart';
import 'package:se_project/provider/user_provider.dart';
import 'package:se_project/models/room_model.dart';

class RoomListScreen extends StatelessWidget {
  final RoomService roomService = RoomService();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.users;

    return Scaffold(
      appBar: AppBar(title: Text("Available Rooms", style: TextStyle(fontWeight: FontWeight.bold))),
      body: StreamBuilder<List<Room>>(
        stream: roomService.getRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No rooms available", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)));
          }

          final rooms = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];

              return Card(
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Room Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          room.imageUrl,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 14),

                      // Room Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Room ${room.roomNumber} - ${room.type}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "₹${room.pricePerNight} / night",
                              style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Capacity: ${room.capacity} Person(s)",
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),

                      // Action Buttons (Arrow + Edit)
                      Row(
                        children: [
                          // Arrow Button for Details
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent, size: 22),
                            onPressed: () {
                              // Navigate to Room Details Page
                              Navigator.pushNamed(context, RoomBookingScreen.routeName, arguments: room);
                            },
                          ),

                          // Edit Button (Only for Admins)
                          if (user != null && user.role == "admin")
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ModifyRoomScreen(room: room),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                backgroundColor: Colors.orange.withOpacity(0.1),
                              ),
                              child: Text("Edit", style: TextStyle(color: Colors.orange, fontSize: 14, fontWeight: FontWeight.w500)),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      // Add Room Button (Visible only for Admins)
      floatingActionButton: user != null && user.role == "admin"
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddRoomScreen(), // Assuming ModifyRoomScreen allows adding a new room
                  ),
                );
              },
              icon: Icon(Icons.add),
              label: Text("Add Room"),
              backgroundColor: Colors.blueAccent,
            )
          : null, // No button if not an admin
    );
  }
}
