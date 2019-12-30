import 'dart:developer' as developer;
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  EventCard({
    @required this.hostName,
    @required this.placeName,
    Key key,
    }): super(key: key);

  final String hostName;
  final String placeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Pop out event details
        developer.log('Card Tapped', name: 'my.app.eventSimulator');
      },
      child: Card(
        color: Theme.of(context).cardColor,
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(Icons.account_circle, size: 50),
                Text(hostName),
              ]
            ),
            Flexible(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('The restaurant image should be inserted here.'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(placeName),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}