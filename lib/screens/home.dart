import 'dart:developer' as Developer;
import 'package:flutter/cupertino.dart';
import 'package:pal_finder/screens/place_search.dart';
import 'package:pal_finder/screens/event_list.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          title: Text('Search'),
        ),
      ]),
      tabBuilder: (context, index) {
        return PlaceSearchScreen();
      }
    );
  }
}