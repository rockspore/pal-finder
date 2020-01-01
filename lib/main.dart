import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pal_finder/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Pal Finder';

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: _title,
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
      home: SplashScreen(),
    );
  }
}
