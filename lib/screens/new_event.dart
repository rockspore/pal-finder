import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pal_finder/data/place.dart';
import 'package:pal_finder/core/networking.dart';

class NewEventScreen extends StatelessWidget {
  final PlaceData placeData;
  final Networking _networking = Networking();

  NewEventScreen({@required this.placeData});

  void _createNewEvent() async {
    final String url = '${_networking.host}/apis/events/';
    try {
      print(placeData.placeId);
      final response = await _networking.post(
        url,
        body: {
          'place_id': placeData.placeId,
          'time': DateTime.now().toIso8601String(),
        },
      );
      print(response.statusCode());
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if(Navigator.canPop(context)) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).pushReplacementNamed('/home');
        }
        return;
      },
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    placeData.placeName,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    placeData.address,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  RaisedButton(
                    onPressed: _createNewEvent,
                    child: Text("Create",
                        style: TextStyle(color: Colors.white,
                            fontSize: 22.0)
                    ),
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}