import 'dart:core';
import 'package:meta/meta.dart';
import 'package:latlong/latlong.dart';
import 'package:pal_finder/data/place.dart';

class EventData {

  EventData({
    @required this.hostName,
    @required this.placeName,
    @required this.location,
    @required this.time,
    @required this.placeData,
  });

  EventData.fromMap(Map<String, dynamic> map, this.placeData)
      : hostName = map['host']['username'],
        placeName = map['place_name'],
        location = LatLng(map['location']['coordinates'][1], map['location']['coordinates'][0]),
        time = DateTime.parse(map['time']);

  final String hostName;
  final String placeName;
  final LatLng location;
  final DateTime time;
  final PlaceData placeData;

  @override
  String toString() {
    return hostName + ': ' + placeName + ' @ ' + time.toString() + ' at location' + location.toString();
  }

}