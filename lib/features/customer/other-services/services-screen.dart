import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';
// import 'package:se_project/features/booking/booking_screen.dart';
import 'package:se_project/features/customer/other-services/services-booking.dart';

class ServicesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {
      'icon': Icons.business_center,
      'title': 'Conference Booking',
      'description': 'Book state-of-the-art conference halls for meetings and events.',
    },
    {
      'icon': Icons.restaurant,
      'title': 'Catering Services',
      'description': 'Delicious meals tailored to your event or stay.',
    },
    {
      'icon': Icons.spa,
      'title': 'Spa & Wellness',
      'description': 'Relax and rejuvenate with premium spa treatments.',
    },
    {
      'icon': Icons.directions_car,
      'title': 'Transport Services',
      'description': 'Luxury transport for your travel convenience.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Services", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // **Icon in a circular background**
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.1),
                      ),
                      child: Icon(service['icon'], size: 32, color: AppColors.primary),
                    ),
                    SizedBox(width: 16),

                    // **Service Details**
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service['title'],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                          ),
                          SizedBox(height: 5),
                          Text(
                            service['description'],
                            style: TextStyle(color: Colors.grey[700]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis, // Prevents text overflow
                          ),
                        ],
                      ),
                    ),

                    // **Book Now Button**
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingScreen(serviceName: service['title']),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("Book", style: TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
