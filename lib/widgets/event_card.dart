import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  EventCard({@required this.name, Key key}): super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Pop out event details
      },
      child: Card(
        child: Text(name),
      ),
    );
  }
}