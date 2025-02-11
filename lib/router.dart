
import 'package:flutter/material.dart';
import 'package:se_project/features/auth/screens/signup-screen.dart';
import 'package:se_project/features/auth/screens/signin-screen.dart';
import 'package:se_project/features/customer/general-screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpScreen.routeName:
         return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>const SignUpScreen()
         );
          case SignInScreen.routeName:
         return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>const SignInScreen()
         );
           case GeneralScreen.routeName:
         return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=> GeneralScreen()
         );
    // case CreateAccountScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const CreateAccountScreen());
    // case LoginScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const LoginScreen());
    // case BottomBar.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const BottomBar());
    // case SettingsScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const SettingsScreen());
   
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exist'),
                ),
              ));
  }
}