import 'package:se_project/features/onboarding/components/onboarding_model.dart';

class OnBoardingData {
  List<OnBoardingModel> items = [
    OnBoardingModel(
      title: 'Effortless Room Booking',
      description: "Book your favorite rooms instantly with our seamless and user-friendly reservation system.",
      image: 'assets/onboarding1.jpg',
    ),
    OnBoardingModel(
      title: 'Personalized Guest Experience',
      description: "Enjoy a tailored stay with customized services, meal preferences, and room settings at your fingertips.",
      image: 'assets/onboarding2.jpg',
    ),
    OnBoardingModel(
      title: 'Real-Time Service Requests',
      description: "Request housekeeping, food delivery, and hotel services in real time with just a tap.",
      image: 'assets/onboarding3.jpg',
    ),
  ];
}
