import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pal_finder/data/place.dart';
import 'package:pal_finder/core/networking.dart';

class NewEventScreen extends StatefulWidget {
  @override
  _NewEventScreenState createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final Networking _networking = Networking();
  final DateFormat _dateTimeFormat = DateFormat.yMd().add_jm();
  DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final PlaceData placeData = ModalRoute.of(context).settings.arguments;
    // void _createNewEvent() async {
    //   final String url = '${_networking.host}/apis/events/';
    //   try {
    //     print(placeData.placeId);
    //     final response = await _networking.post(
    //       url,
    //       body: {
    //         'place_id': placeData.placeId,
    //         'time': _selectedDateTime.toIso8601String(),
    //       },
    //     );
    //     print(response.statusCode());
    //   } catch (err) {
    //     print(err);
    //   }
    // }
    return Scaffold(
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
                Divider(),
                GestureDetector(
                  onTap: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2200, 1, 1),
                      onConfirm: (DateTime dateTime) {
                        print('confirm $dateTime');
                        setState(() {
                          _selectedDateTime = dateTime;
                        });
                      },
                      currentTime: _selectedDateTime,
                      locale: LocaleType.zh
                    );
                  },
                  child: Text(
                    _dateTimeFormat.format(_selectedDateTime),
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 15.0,
                ),
                RaisedButton(
                  onPressed: () async {
                    final String url = '${_networking.host}/apis/events/';
                    try {
                      print(placeData.placeId);
                      final response = await _networking.post(
                        url,
                        body: {
                          'place_id': placeData.placeId,
                          'time': _selectedDateTime.toIso8601String(),
                        },
                      );
                      print(response.statusCode());
                    } catch (err) {
                      print(err);
                    }
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                  },
                  child: Text(
                    "Create",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
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
    );
  }
}