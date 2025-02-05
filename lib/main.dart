
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se_project/constants/app-themes.dart';
import 'package:se_project/constants/size_config.dart';
import 'package:se_project/features/onboarding/screens/onboarding-screen.dart';
import 'package:se_project/router.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );

  runApp(
    
    MyApp()
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    // authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClubHub',
      theme: AppTheme.themeData,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: OnBoardingScreen(),
    );
  }

  // Widget _getHomeScreen() {
  //   return Consumer<UserProvider>(
  //     builder: (context, userProvider, _) {
  //       if (userProvider.user.token.isNotEmpty) {
  //         if (userProvider.user.type == 'user') {
  //           return const BottomBar();
  //         } else if (userProvider.user.type == 'club-manager') {
  //           return ClubManagerBottomBar(clubId:  userProvider.user.clubOwned );
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