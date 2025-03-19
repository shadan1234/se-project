import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/constants/app-themes.dart';
import 'package:se_project/constants/size_config.dart';
import 'package:se_project/features/auth/screens/auth-main-screen.dart';
import 'package:se_project/features/onboarding/screens/onboarding-screen.dart';
import 'package:se_project/features/provider/user_provider.dart';
// import 'package:se_project/providers/user_provider.dart'; // Import UserProvider
import 'package:se_project/router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()), // Add UserProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SE Project',
      theme: AppTheme.themeData,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: AuthMainScreen(), // Change this to `_getHomeScreen()` if needed
    );
  }

  // Function to decide the home screen based on user role
  // Widget _getHomeScreen() {
  //   return Consumer<UserProvider>(
  //     builder: (context, userProvider, _) {
  //       if (userProvider.user != null) {
  //         if (userProvider.user!.type == 'user') {
  //           return const BottomBar();
  //         } else if (userProvider.user!.type == 'club-manager') {
  //           return ClubManagerBottomBar(clubId: userProvider.user!.clubOwned);
  //         } else {
  //           return const SuperAdminBottomBar();
  //         }
  //       } else {
  //         return const OnBoardingScreen();
  //       }
  //     },
  //   );
  // }
}
