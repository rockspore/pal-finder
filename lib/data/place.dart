import 'dart:core';
import 'package:meta/meta.dart';
import 'package:latlong/latlong.dart';

class PlaceData {

  PlaceData({
    @required this.placeId,
    @required this.placeName,
    @required this.location,
    @required this.placeIconURL,
    @required this.address,
  });

  PlaceData.fromMap(Map<String, dynamic> map)
      : placeName = map['name'],
        location = LatLng(map['geometry']['location']['lat'], map['geometry']['location']['lng']),
        placeIconURL = map['icon'],
        address = map['formatted_address'],
        placeId = map['place_id'];

  final String placeName;
  final LatLng location;
  final String placeIconURL;
  final String address;
  final String placeId;

  @override
  String toString() {
    return placeName + ' at ' + location.toString();
  }

}