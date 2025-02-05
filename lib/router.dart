
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
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