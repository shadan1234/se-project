
import 'package:flutter/material.dart';
import 'package:se_project/features/admin/add_room_screen.dart';
import 'package:se_project/features/admin/general-screen-admin.dart';
import 'package:se_project/features/admin/image_upload-screen.dart';
import 'package:se_project/features/auth/screens/auth-main-screen.dart';
import 'package:se_project/features/auth/screens/signup-screen.dart';
import 'package:se_project/features/auth/screens/signin-screen.dart';
import 'package:se_project/features/customer/booking/room-booking.dart';
import 'package:se_project/features/customer/general-screen.dart';
import 'package:se_project/models/room_model.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
     case AuthMainScreen.routeName:
         return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>const AuthMainScreen()
         );
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
            case AdminScreen.routeName:
         return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=> AdminScreen()
         );
         case AdminImageUploadScreen.routeName:
         return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>AdminImageUploadScreen()
         );
         case AddRoomScreen.routeName:
         return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>AddRoomScreen()
         );
        case RoomBookingScreen.routeName:
  final room = routeSettings.arguments as Room;
  return MaterialPageRoute(
    settings: routeSettings,
    builder: (_) => RoomBookingScreen(room: room),
  );

   
   
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