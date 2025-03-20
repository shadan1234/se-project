import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:se_project/constants/colors.dart';

class ReportsScreen extends StatelessWidget {
  @override
  String _getMonth(int month) {
  List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
  return months[month - 1];
}

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Reports & Analytics", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Revenue Overview", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 16),

         StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null) {
      return Center(child: Text("No Revenue Data Available"));
    }

    var bookings = snapshot.data!.docs;
    Map<String, double> revenueData = {
      "Jan": 0, "Feb": 0, "Mar": 0, "Apr": 0, "May": 0, "Jun": 0
    };

    for (var booking in bookings) {
      var data = booking.data() as Map<String, dynamic>;
      if (data.containsKey('pricePerNight') && data.containsKey('checkInDate')) {
        DateTime checkIn = DateTime.parse(data['checkInDate']);
        String month = _getMonth(checkIn.month);
        if (revenueData.containsKey(month)) {
          revenueData[month] = revenueData[month]! + (data['pricePerNight'] as num).toDouble();
        }
      }
    }

    return _buildRevenueChart(revenueData);
  },
),



            SizedBox(height: 24),
            Text("Occupancy Rate", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 8),

            // Occupancy Data
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text("No Room Data Available"));
                }

                var rooms = snapshot.data!.docs;
                int totalRooms = rooms.length;
                int occupiedRooms = rooms.where((room) => room['status'] == "Booked").length;
                int vacantRooms = totalRooms - occupiedRooms;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard("Total Rooms", "$totalRooms", Icons.meeting_room, Colors.blue),
                    _buildStatCard("Occupied", "$occupiedRooms", Icons.hotel, Colors.green),
                    _buildStatCard("Vacant", "$vacantRooms", Icons.warning, Colors.orange),
                  ],
                );
              },
            ),

            SizedBox(height: 24),
            Text("Recent Reports", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 8),

            // Recent Reports Data
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('bookings').orderBy('timestamp', descending: true).limit(3).snapshots(),
              builder: (context, snapshot1) {
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('services-booking').orderBy('timestamp', descending: true).limit(2).snapshots(),
                  builder: (context, snapshot2) {
                    if (snapshot1.connectionState == ConnectionState.waiting || snapshot2.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<dynamic> reports = [];
                    if (snapshot1.hasData && snapshot1.data != null) {
                      reports.addAll(snapshot1.data!.docs.map((doc) => {
                        "title": "Room Booking: ${doc['roomType']}",
                        "date": doc['checkInDate'].toString().split('T')[0]
                      }));
                    }
                    if (snapshot2.hasData && snapshot2.data != null) {
                      reports.addAll(snapshot2.data!.docs.map((doc) => {
                        "title": "Service: ${doc['serviceName']}",
                        "date": doc['date']
                      }));
                    }

                    if (reports.isEmpty) {
                      // Static data when no reports
                      reports = [
                        {"title": "Room Booking: Deluxe", "date": "2025-03-01"},
                        {"title": "Service: Laundry", "date": "2025-03-02"},
                      ];
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          var report = reports[index];
                          return _buildReportTile(
                            report['title'] ?? "Unknown Report",
                            report['date'] ?? "No Date",
                            Icons.insert_chart,
                            Colors.blue,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildRevenueChart(Map<String, double> revenueData) {
  List<BarChartGroupData> barGroups = [];
  int index = 0;

  revenueData.forEach((month, revenue) {
    barGroups.add(
      BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: revenue,
            color: Colors.green,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
    index++;
  });

  return Container(
    height: 250,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Revenue (Last 6 Months)", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
        SizedBox(height: 10),
        Expanded(
          child: BarChart(
            BarChartData(
              barGroups: barGroups,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      List<String> months = revenueData.keys.toList();
                      return Text(months[value.toInt()], style: TextStyle(fontSize: 12));
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1000, // Adjust for scaling
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: true),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: color),
          SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
          SizedBox(height: 4),
          Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: AppColors.secondaryText)),
        ],
      ),
    );
  }

  Widget _buildReportTile(String title, String subtitle, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.download, color: AppColors.primary),
        onTap: () {
          // Report download functionality
        },
      ),
    );
  }
}
