import 'package:flutter/material.dart';
import 'package:pal_finder/screens/event_list.dart';
import 'package:pal_finder/widgets/form_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Pal Finder';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Column(
          children: <Widget>[
            MyStatefulWidget(),
            Expanded(
              child: EventList(),
            )
          ],
        )
      ),
    );
  }
}
