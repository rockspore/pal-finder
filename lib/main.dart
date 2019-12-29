import 'package:flutter/material.dart';
import 'package:pal_finder/screens/event_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pal Finder',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: EventList(),
    );
  }
}
