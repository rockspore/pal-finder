import 'package:flutter/material.dart';
import 'package:pal_finder/screens/home.dart';
import 'package:pal_finder/screens/login.dart';
import 'package:pal_finder/screens/place_search.dart';
import 'package:pal_finder/screens/event.dart';

// final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Pal Finder';

  @override
  Widget build(BuildContext context) {
    // print('Building MyApp');
    return MaterialApp(
      title: _title,
      // navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/place': (context) => PlaceSearchScreen(),
        '/event_detail':(context) => EventScreen(),
      },
    );
  }
}
