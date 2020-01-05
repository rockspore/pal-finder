import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pal_finder/core/networking.dart';
import 'package:pal_finder/data/event.dart';

class EventCard extends StatelessWidget {
  EventCard(this._eventData, {Key key}): super(key: key);

  final EventData _eventData;
  final DateFormat _dateFormat = DateFormat.yMd();
  final DateFormat _timeFormat = DateFormat.jm();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/event_detail', arguments: _eventData);
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
                _buildProfile(),
              ]
            ),
            Flexible(
              child: Column(
                children: <Widget>[
                  _buildPlaceImage(),
                  // Divider(),
                  ListTile(
                    title: Text(_eventData.placeName),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceImage() => Container(
    height: 120,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(
          GooglePlacesApi().photoUrl(_eventData.placeData.photoRef),
        ),
      ),
    ),
  );

  Widget _buildProfile() => Container(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _eventData.hostName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(_dateFormat.format(_eventData.time)),
        Text(_timeFormat.format(_eventData.time)),
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