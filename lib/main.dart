import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pal_finder/screens/home.dart';
import 'package:pal_finder/screens/login.dart';
import 'package:pal_finder/screens/place_search.dart';
import 'package:pal_finder/screens/splash.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Pal Finder';

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: _title,
      navigatorKey: navigatorKey,
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/place': (context) => PlaceSearchScreen(),
      },
      home: PlaceSearchScreen(),
    );
  }
}
