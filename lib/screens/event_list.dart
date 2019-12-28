import 'package:flutter/material.dart';
import 'package:pal_finder/widgets/event_card.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final list = <String>['California', 'LaoLiuMang', 'Yang', 'Zhenghua'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index >= list.length) {
          return null;
        }
        return EventCard(name: list[index]);
      },
    );
  }
}