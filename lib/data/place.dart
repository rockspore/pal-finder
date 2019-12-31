import 'dart:core';
import 'package:meta/meta.dart';
import 'package:latlong/latlong.dart';

class PlaceData {

  PlaceData({
    @required this.placeName,
    @required this.location,
    @required this.placeIconURL,
  });

  PlaceData.fromMap(Map<String, dynamic> map)
      : placeName = map['name'],
        location = LatLng(map['geometry']['location']['lat'], map['geometry']['location']['lng']),
        placeIconURL = map['icon'];

  final String placeName;
  final LatLng location;
  final String placeIconURL;

  @override
  String toString() {
    return placeName + ' at ' + location.toString();
  }

}