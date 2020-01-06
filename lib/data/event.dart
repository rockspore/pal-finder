import 'dart:core';
import 'package:meta/meta.dart';
import 'package:latlong/latlong.dart';
import 'package:pal_finder/data/place.dart';
import 'package:pal_finder/data/user.dart';

class EventData {

  EventData({
    @required this.hostData,
    @required this.placeName,
    @required this.location,
    @required this.time,
    @required this.placeData,
  });

  EventData.fromMap(Map<String, dynamic> map, this.placeData)
      : hostData = UserData.fromMap(map['host']),
        placeName = map['place_name'],
        location = LatLng(map['location']['coordinates'][1], map['location']['coordinates'][0]),
        time = DateTime.parse(map['time']);

  final UserData hostData;
  final String placeName;
  final LatLng location;
  final DateTime time;
  final PlaceData placeData;

  @override
  String toString() {
    return hostData.username + ': ' + placeData.placeName;
  }

}