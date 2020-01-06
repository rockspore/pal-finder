import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:pal_finder/data/place.dart';
import 'package:pal_finder/core/networking.dart';

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
        Navigator.pushNamed(
          context,
          '/event_create',
          arguments: placeData,
        );
      },
      child: Card(
        elevation: 10,
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildPlaceImage(),
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
    );
  }

  // Widget _buildProfilePhoto() {
  //   return Container(
  //     width: 120,
  //     height: 120,
  //     color: Colors.grey,
  //     alignment: Alignment.center,
  //     child: Image.network(placeData.placeIconURL),
  //   );
  // }

    Widget _buildPlaceImage() => Container(
    height: 120,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(
          GooglePlacesApi().photoUrl(placeData.photoRef),
        ),
      ),
    ),
  );
}