import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pal_finder/widgets/event_card.dart';
import 'package:pal_finder/data/place.dart';

class PlaceList extends StatefulWidget {
  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  final _placeList = <PlaceData>[];

  @override
  void initState() {
    super.initState();
    _getDummyData();
  }

  void _getDummyData() {
    final String jsonString = '{"count":8,"next":null,"previous":null,"results":[{"id":2,"host":{"id":1,"username":"yiran"},"place_id":"ChIJN1t_tDeuEmsRUsoyG83frY4","place_name":"Google Australia","location":{"type":"Point","coordinates":[151.1958527,-33.8666199]},"time":"2019-12-23T06:54:01.808904Z"},{"id":3,"host":{"id":1,"username":"yiran"},"place_id":"ChIJN1t_tDeuEmsRUsoyG83frY4","place_name":"Google Australia","location":{"type":"Point","coordinates":[151.1958324,-33.8666114]},"time":"2019-12-27T01:29:47.305318Z"},{"id":4,"host":{"id":1,"username":"yiran"},"place_id":"ChIJN1t_tDeuEmsRUsoyG83frY4","place_name":"Google Australia","location":{"type":"Point","coordinates":[151.1958324,-33.8666114]},"time":"2019-12-27T01:31:39.740508Z"},{"id":5,"host":{"id":1,"username":"yiran"},"place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.1989921,-33.8710748]},"time":"2019-12-29T06:25:33.576409Z"},{"id":6,"host":{"id":1,"username":"yiran"},"place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.1989921,-33.8710748]},"time":"2019-12-29T06:26:13.541737Z"},{"id":7,"host":{"id":1,"username":"yiran"},"place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.1989921,-33.8710748]},"time":"2019-12-29T06:41:17.200507Z"},{"id":1,"host":{"id":1,"username":"yiran"},"place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.19893310349227,-33.87103020721423]},"time":"2019-12-29T21:18:45.084885Z"},{"id":8,"host":{"id":1,"username":"yiran"},"place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.1989921,-33.8710748]},"time":"2019-12-29T21:19:18.876416Z"}]}';
    var jsonData = jsonDecode(jsonString);
    jsonData = jsonData['results'] as List;
    jsonData.forEach((item) {
      _placeList.add(PlaceData.fromMap(item));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Color.fromRGBO(128, 128, 128, 1)),
      child: ListView.builder(
        itemCount: _placeList.length,
        itemBuilder: (context, index) {
          final Place = _placeList[index];
          return PlaceCard(
            hostName: Place.hostName,
            placeName: Place.placeName,
          );
        },
      ),
    );
  }
}