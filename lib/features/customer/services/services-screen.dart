import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';

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
        title: Text("Our Services"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/booking', arguments: service['title']);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                margin: EdgeInsets.only(bottom: 16),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(service['icon'], size: 40, color: AppColors.primary),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              service['description'],
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
