import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedRoom;
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int guests = 1;
  
  final List<String> roomTypes = [
    "Deluxe Room",
    "Suite",
    "Presidential Suite",
    "Standard Room"
  ];

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    DateTime initialDate = isCheckIn ? DateTime.now() : (checkInDate ?? DateTime.now()).add(Duration(days: 1));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != checkInDate && picked != checkOutDate) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          if (checkOutDate != null && checkOutDate!.isBefore(checkInDate!)) {
            checkOutDate = checkInDate!.add(Duration(days: 1));
          }
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Your Stay", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Room Type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedRoom,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: roomTypes.map((room) {
                return DropdownMenuItem<String>(
                  value: room,
                  child: Text(room),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRoom = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text("Select Check-in & Check-out Dates", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(checkInDate == null ? "Check-in Date" : DateFormat.yMMMd().format(checkInDate!),
                              style: TextStyle(color: Colors.black)),
                          Icon(Icons.calendar_today, color: AppColors.primary),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(checkOutDate == null ? "Check-out Date" : DateFormat.yMMMd().format(checkOutDate!),
                              style: TextStyle(color: Colors.black)),
                          Icon(Icons.calendar_today, color: AppColors.primary),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Number of Guests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: guests,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: List.generate(5, (index) => index + 1).map((number) {
                return DropdownMenuItem<int>(
                  value: number,
                  child: Text("$number Guest${number > 1 ? 's' : ''}"),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  guests = value!;
                });
              },
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedRoom != null && checkInDate != null && checkOutDate != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Booking Confirmed for $selectedRoom from ${DateFormat.yMMMd().format(checkInDate!)} to ${DateFormat.yMMMd().format(checkOutDate!)}")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please complete all fields")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Confirm Booking", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
