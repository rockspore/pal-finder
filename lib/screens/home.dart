import 'package:flutter/material.dart';
import 'package:pal_finder/widgets/event_list.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 0.5,
      ),
      body: EventList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/place'),
        tooltip: 'Add an Event',
        child: Icon(Icons.add),
      ),
    );
  }

}