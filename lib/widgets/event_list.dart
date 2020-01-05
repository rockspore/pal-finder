import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pal_finder/widgets/event_card.dart';
import 'package:pal_finder/data/event.dart';
import 'package:pal_finder/data/place.dart';
import 'package:pal_finder/core/networking.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final _eventList = <EventData>[];
  final _eventFetcher = EventFetcher(31.0252201, 121.4337784, 0.5);
  Future<bool> _future;

  @override
  void initState() {
    super.initState();
    _loadFuture();
  }

  void _loadFuture() {
    _future = _eventFetcher.fetchNextPage(context).then(
      (List<EventData> newEvents) {
        if (newEvents.isEmpty) {
          setState(() {});
          return false;
        } else {
          setState(() {
            _eventList.addAll(newEvents);
          });
          return true;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('Building event list in $context');
    return FutureBuilder<bool>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        int listSize = _eventList.length;
        if (!snapshot.hasData || snapshot.data) {
          // print('snapshot.hasData: ${snapshot.hasData}');
          // if (snapshot.hasData) {
          //   print('snapshot.data: ${snapshot.data}');
          // }
          ++listSize;
        }
        return DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: ListView.builder(
            itemCount: listSize,
            itemBuilder: (context, index) {
              // print('called list builder inside $context with index $index');
              if (index >= _eventList.length) {
                if (snapshot.hasData) {
                  _loadFuture();
                }
                return Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Text('Loading...'),
                );
              }
              final event = _eventList[index];
              return EventCard(event);
            },
          ),
        );
      },
    );
  }
}

class EventFetcher {
  EventFetcher(this._lat, this._lng, this._dist) {
    _nextUrl ='${_networking.host}/apis/events/nearby/?lng=${_lng.toStringAsFixed(6)}&lat=${_lat.toStringAsFixed(6)}&dist=${_dist.toStringAsFixed(3)}';
  }

  final double _lat;
  final double _lng;
  final double _dist;
  final Networking _networking = Networking();
  String _nextUrl;

  Future<List<EventData>> fetchNextPage(BuildContext context) async {
    final eventList = <EventData>[];
    if (_nextUrl != null) {
      // print('using Networking to get');
      final response = await _networking.get(_nextUrl);
      // print('response code is ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final list = data['results'] as List;
        final detailsFutures = <Future>[];
        // TODO: clean this mess up. May need to change the server data model to include photoreference
        list.forEach((eventMap) {
          detailsFutures.add(GooglePlacesApi().placeDetails(eventMap['place_id']));
        });
        final detailsList = await Future.wait(detailsFutures);
        for (int i = 0; i < list.length; i++) {
          eventList.add(EventData.fromMap(list[i], PlaceData.fromMap(detailsList[i])));
        }
        _nextUrl = data['next'];
      } else {
        _networking.handleResponseCode(context, response.statusCode);
      }
    }
    return eventList;
  }
}
