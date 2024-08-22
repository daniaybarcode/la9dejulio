import 'package:flutter/material.dart';
import 'package:nuevedejulio/screens/event_public_screen.dart';
import 'package:nuevedejulio/screens/home_screen.dart';
//import 'package:admin_digiticket2024/screens/user_screen.dart';
import 'package:nuevedejulio/screens/event_screen.dart';
//import 'package:admin_digiticket2024/screens/event_public_screen.dart';
///import 'package:your_app/screens/place_screen.dart';
//import 'package:your_app/screens/show_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomeScreen(),
  //'/users': (context) => UserScreen(),
  '/proximos_eventos': (context) => EventPublicScreen(),
 // '/eventspublic': (context) => EventPublicScreen(),
 // '/places': (context) => PlaceScreen(),
 // '/shows': (context) => ShowScreen(),
};
