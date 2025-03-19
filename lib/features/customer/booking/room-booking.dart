import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:se_project/features/customer/booking/booking-service.dart';
import 'package:se_project/models/room_model.dart';

class RoomBookingScreen extends StatefulWidget {
   static const String routeName="room-booking";
  final Room room;

  RoomBookingScreen({required this.room});

  @override
  _RoomBookingScreenState createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int guests = 1;

  void selectDate({required bool isCheckIn}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = pickedDate;
          checkOutDate = null; // Reset check-out date
        } else {
          if (checkInDate != null && pickedDate.isAfter(checkInDate!)) {
            checkOutDate = pickedDate;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Check-out date must be after check-in date.")),
            );
          }
        }
      });
    }
  }

  int calculateTotalPrice() {
    if (checkInDate == null || checkOutDate == null) return 0;
    int nights = checkOutDate!.difference(checkInDate!).inDays;
    return nights * widget.room.pricePerNight;
  }

  void bookRoom(String paymentMethod) {
    if (checkInDate == null || checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select check-in and check-out dates")),
      );
      return;
    }
BookingService().bookRoom(
  roomId: widget.room.id,
  roomNumber: widget.room.roomNumber,
  roomType: widget.room.type,
  pricePerNight: widget.room.pricePerNight,
  capacity: widget.room.capacity,
  checkInDate: checkInDate!,
  checkOutDate: checkOutDate!,
  paymentWay: paymentMethod
);

    // Proceed with booking logic (API call / save to database)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Booking Confirmed!"),
        content: Text("You have successfully booked ${widget.room.type} from ${DateFormat('dd MMM yyyy').format(checkInDate!)} to ${DateFormat('dd MMM yyyy').format(checkOutDate!)}.\nPayment: $paymentMethod"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Room")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(widget.room.imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 12),

            // Room Info
            Text(
              "${widget.room.type} - Room ${widget.room.roomNumber}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "₹${widget.room.pricePerNight} per night",
              style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),

            // Date Pickers
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => selectDate(isCheckIn: true),
                    child: buildDateCard("Check-In", checkInDate),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => selectDate(isCheckIn: false),
                    child: buildDateCard("Check-Out", checkOutDate),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Guests Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Guests", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: guests > 1 ? () => setState(() => guests--) : null,
                    ),
                    Text("$guests", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: guests < widget.room.capacity ? () => setState(() => guests++) : null,
                    ),
                  ],
                ),
              ],
            ),
            Divider(),

            // Total Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Price", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("₹${calculateTotalPrice()}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
              ],
            ),
            SizedBox(height: 12),

            // Payment Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => bookRoom("Online Payment"),
                    child: Text("Pay Now"),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => bookRoom("Pay at Hotel"),
                    child: Text("Pay at Hotel"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateCard(String label, DateTime? date) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          SizedBox(height: 4),
          Text(
            date == null ? "Select Date" : DateFormat('dd MMM yyyy').format(date),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
