// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pal_finder/screens/home.dart';
import 'package:pal_finder/screens/login.dart';
import 'package:pal_finder/screens/splash.dart';

// final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Pal Finder';

  @override
  Widget build(BuildContext context) {
    print('Building MyApp');
    return CupertinoApp(
      title: _title,
      // navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
      // home: SplashScreen(),
    );
  }
}
