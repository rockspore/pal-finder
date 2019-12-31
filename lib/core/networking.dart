// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:pal_finder/data/event.dart';

// class EventFetcher {
//   EventFetcher({
//     @required this.lat,
//     @required this.lng,
//     @required this.dist,
//   })
//       : nextUrl='http://10.0.2.2:8000/apis/events/nearby/?lng=${lng.toStringAsFixed(6)}&lat=${lat.toStringAsFixed(6)}&dist=${dist.toStringAsFixed(3)}';

//   final double lat;
//   final double lng;
//   final double dist;
//   String nextUrl;

//   Future<List<EventData>> fetchNextPage() async {
//     final eventList = <EventData>[];
//     if (nextUrl != null) {
//       final response = await http.get(
//         nextUrl,
//         headers: {
//           HttpHeaders.authorizationHeader: 'Token b0998f43d3cb06e03f9dce4dd4e7816bc12eaa74'
//         },
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as Map<String, dynamic>;
//         final list = data['results'] as List;
//         list.forEach((eventMap) {
//           eventList.add(EventData.fromMap(eventMap));
//         });
//         nextUrl = data['next'];
//       } else {
//         throw Exception('Fail to load events.');
//       }
//     }
//     return eventList;
//   }
// }
