import 'dart:developer' as developer;
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  EventCard({@required this.name, Key key}): super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Pop out event details
        developer.log('Card Tapped', name: 'my.app.eventSimulator');
      },
      child: Card(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(name),
        ),
      ),
    );
  }
}