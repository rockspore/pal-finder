import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pal_finder/widgets/event_card.dart';
import 'package:pal_finder/data/event.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final _eventList = <EventData>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDummyData();
  }

  void _getDummyData() {
    final String jsonString = '{"count":4,"next":null,"previous":null,"results":[{"id":2,"host":"http://localhost:8000/apis/users/1/","place_id":"ChIJN1t_tDeuEmsRUsoyG83frY4","place_name":"Google Australia","location":{"type":"Point","coordinates":[151.1958527,-33.8666199]},"time":"2019-12-23T06:54:01.808904Z"},{"id":1,"host":"http://localhost:8000/apis/users/1/","place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.19893310349227,-33.87103020721423]},"time":"2019-12-26T03:36:02.982607Z"},{"id":3,"host":"http://localhost:8000/apis/users/1/","place_id":"ChIJN1t_tDeuEmsRUsoyG83frY4","place_name":"Google Australia","location":{"type":"Point","coordinates":[151.1958324,-33.8666114]},"time":"2019-12-27T01:29:47.305318Z"},{"id":4,"host":"http://localhost:8000/apis/users/1/","place_id":"ChIJN1t_tDeuEmsRUsoyG83frY4","place_name":"Google Australia","location":{"type":"Point","coordinates":[151.1958324,-33.8666114]},"time":"2019-12-27T01:31:39.740508Z"}]}';
    var jsonData = jsonDecode(jsonString);
    jsonData = jsonData['results'] as List;
    jsonData.forEach((item) {
      _eventList.add(EventData.fromMap(item));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: ListView.builder(
        itemCount: _eventList.length,
        itemBuilder: (context, index) {
          return EventCard(name: _eventList[index].toString());
        },
      ),
    );
  }
}