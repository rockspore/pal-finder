import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:pal_finder/data/place.dart';
import 'package:pal_finder/screens/new_event.dart';

class PlaceCard extends StatelessWidget {
  PlaceCard({
    @required this.placeData,
    Key key,
    }): super(key: key);

  final PlaceData placeData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        developer.log('Place Card Tapped', name: 'my.app.eventSimulator');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewEventScreen(placeData: placeData),
          ),
        );
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
              ]
            ),
            Flexible(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(placeData.placeName),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(placeData.address),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePhoto() {
    return Container(
      width: 120,
      height: 120,
      color: Colors.grey,
      alignment: Alignment.center,
      child: Image.network(placeData.placeIconURL),
    );
  }
}