import 'dart:developer' as developer;
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  PlaceCard({
    @required this.placeName,
    Key key,
    }): super(key: key);

  final String placeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        developer.log('Card Tapped', name: 'my.app.eventSimulator');
      },
      child: Card(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildProfilePhoto(),
                _buildProfile(context),
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

  Widget _buildProfile(BuildContext context) => Container(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Tonight'),
        Text('5:00 pm'),
      ],
    ),
  );

  Widget _buildProfilePhoto() {
    return Container(
      width: 120,
      height: 120,
      color: Colors.grey,
      alignment: Alignment.center,
      child: Icon(Icons.account_circle, size: 80),
    );
  }
}