import 'package:flutter/material.dart';
import 'package:pal_finder/data/event.dart';

class EventScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final EventData eventData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://australiabusinessnews.com.au/wp-content/uploads/2016/11/shutterstock_192086159-1170x780.jpg',
                ),
              ),
            ),
          ),
          Container(
            height: 120,
            child: Text(eventData.placeName),
          ),
        ],
      ),
    );
  }

}