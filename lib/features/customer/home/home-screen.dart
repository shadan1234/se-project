import 'package:flutter/material.dart';
import 'package:se_project/constants/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    String? videoId = YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=5MgBikgcWnY');
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    }
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Grand Hotel", style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/hotel.jpg"), // Ensure the image exists in assets
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Hotel Features
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Explore Our Services",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ),
            SizedBox(height: 10),
            _buildFeatureCard(Icons.hotel, "Book Luxurious Rooms", "Comfortable and premium stay options."),
            _buildFeatureCard(Icons.restaurant, "Fine Dining", "Enjoy delicious meals from top chefs."),
            _buildFeatureCard(Icons.spa, "Wellness & Spa", "Relax and rejuvenate with our spa treatments."),
            _buildFeatureCard(Icons.support_agent, "24/7 Concierge", "Personalized services for a smooth stay."),
            SizedBox(height: 20),
            // Hotel Tour Video
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Hotel Tour Video",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _youtubeController,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: AppColors.primary,
                ),
                builder: (context, player) {
                  return Column(
                    children: [player],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String subtitle) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: 30),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[700])),
      ),
    );
  }
}
