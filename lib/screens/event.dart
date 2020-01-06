import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pal_finder/core/networking.dart';
import 'package:pal_finder/data/event.dart';

class EventScreen extends StatelessWidget {
  final DateFormat _dateTimeFormat = DateFormat.yMd().add_jm();

  @override
  Widget build(BuildContext context) {
    final EventData eventData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  GooglePlacesApi().photoUrl(eventData.placeData.photoRef),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            child: Center(
              child: Text(
                eventData.placeName,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            child: Center(
              child: Text(
                _dateTimeFormat.format(eventData.time),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            child: Row(
              children: <Widget>[
                _buildProfilePhoto(eventData),
                Expanded(
                  child: Center(
                    child: Text(
                      eventData.hostData.fullName,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    // TODO: Implement message function
                  },
                  child: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhoto(EventData eventData) {
    return Container(
      width: 100,
      height: 100,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     fit: BoxFit.cover,
      //     image: NetworkImage(
      //       GooglePlacesApi().photoUrl(eventData.placeData.photoRef),
      //     ),
      //   ),
      // ),
      child: Container(
        alignment: Alignment.center,
        child: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(eventData.hostData.profilePhotoUrl),
        ),
      ),

    );
  }

}