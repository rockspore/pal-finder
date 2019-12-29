import 'dart:core';
import 'package:meta/meta.dart';
import 'package:latlong/latlong.dart';

class EventData {

  EventData({
    @required this.host,
    @required this.placeName,
    @required this.location,
    @required this.time,
  });

  EventData.fromMap(Map<String, dynamic> map)
      : host = map['host'],
        placeName = map['place_name'],
        location = LatLng(map['location']['coordinates'][1], map['location']['coordinates'][0]),
        time = DateTime.parse(map['time']);

  final String host;
  final String placeName;
  final LatLng location;
  final DateTime time;

  @override
  String toString() {
    return host + ': ' + placeName + ' @ ' + time.toString() + ' at location' + location.toString();
  }

}