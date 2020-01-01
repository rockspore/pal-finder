import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pal_finder/widgets/event_card.dart';
import 'package:pal_finder/data/event.dart';
// import 'package:pal_finder/core/networking.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final _eventList = <EventData>[];
  final _eventFetcher = EventFetcher(
    lat: -33.870481,
    lng: 151.195697,
    dist: 0.5,
  );

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _getDummyData();
  // }

  // void _getDummyData() {
  //   final String jsonString = '{"count":8,"next":null,"previous":null,"results":[{"id":2,"host":{"id":1,"username":"yiran"},"place_id":"ChIJN1t_tDeuEmsRUsoyG83frY4","place_name":"Google Australia","location":{"type":"Point","coordinates":[151.1958527,-33.8666199]},"time":"2019-12-23T06:54:01.808904Z"},{"id":3,"host":{"id":1,"username":"yiran"},"place_id":"ChIJN1t_tDeuEmsRUsoyG83frY4","place_name":"Google Australia","location":{"type":"Point","coordinates":[151.1958324,-33.8666114]},"time":"2019-12-27T01:29:47.305318Z"},{"id":4,"host":{"id":1,"username":"yiran"},"place_id":"ChIJN1t_tDeuEmsRUsoyG83frY4","place_name":"Google Australia","location":{"type":"Point","coordinates":[151.1958324,-33.8666114]},"time":"2019-12-27T01:31:39.740508Z"},{"id":5,"host":{"id":1,"username":"yiran"},"place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.1989921,-33.8710748]},"time":"2019-12-29T06:25:33.576409Z"},{"id":6,"host":{"id":1,"username":"yiran"},"place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.1989921,-33.8710748]},"time":"2019-12-29T06:26:13.541737Z"},{"id":7,"host":{"id":1,"username":"yiran"},"place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.1989921,-33.8710748]},"time":"2019-12-29T06:41:17.200507Z"},{"id":1,"host":{"id":1,"username":"yiran"},"place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.19893310349227,-33.87103020721423]},"time":"2019-12-29T21:18:45.084885Z"},{"id":8,"host":{"id":1,"username":"yiran"},"place_id":"ChIJkeO_AzquEmsRUpGQn1ZK7Tg","place_name":"Harbour Bar & Kitchen","location":{"type":"Point","coordinates":[151.1989921,-33.8710748]},"time":"2019-12-29T21:19:18.876416Z"}]}';
  //   var jsonData = jsonDecode(jsonString);
  //   jsonData = jsonData['results'] as List;
  //   jsonData.forEach((item) {
  //     _eventList.add(EventData.fromMap(item));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Color.fromRGBO(128, 128, 128, 1)),
      child: ListView.builder(
        itemCount: _eventList.length + 1,
        itemBuilder: (context, index) {
          if (index >= _eventList.length) {
            _eventFetcher.fetchNextPage().then((List<EventData> newList) {
              setState(() {
                _eventList.addAll(newList);
              });
            });
            return Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Text('Loading...'),
            );
          }
          final event = _eventList[index];
          return EventCard(
            event: event,
          );
        },
      ),
    );
  }
}

class EventFetcher {
  EventFetcher({
    @required this.lat,
    @required this.lng,
    @required this.dist,
  }) {
    if (Platform.isIOS) {
      nextUrl='http://localhost:8000/apis/events/nearby/?lng=${lng.toStringAsFixed(6)}&lat=${lat.toStringAsFixed(6)}&dist=${dist.toStringAsFixed(3)}';
    } else if (Platform.isAndroid) {
      nextUrl='http://10.0.2.2:8000/apis/events/nearby/?lng=${lng.toStringAsFixed(6)}&lat=${lat.toStringAsFixed(6)}&dist=${dist.toStringAsFixed(3)}';
    }
  }

  final double lat;
  final double lng;
  final double dist;
  String nextUrl;

  Future<List<EventData>> fetchNextPage() async {
    final eventList = <EventData>[];
    if (nextUrl != null) {
      final response = await http.get(
        nextUrl,
        headers: {
          HttpHeaders.authorizationHeader: 'Token fc27c2274f456cf0e7bd00663035a8c94ada0025'
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final list = data['results'] as List;
        list.forEach((eventMap) {
          eventList.add(EventData.fromMap(eventMap));
        });
        nextUrl = data['next'];
      } else {
        throw Exception('Fail to load events.');
      }
    }
    return eventList;
  }
}
