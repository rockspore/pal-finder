import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pal_finder/widgets/place_card.dart';
import 'package:pal_finder/data/place.dart';

class PlaceList extends StatefulWidget {
  final List<PlaceData> placeList;

  PlaceList(this.placeList);

  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
        itemCount: widget.placeList.length,
        itemBuilder: (context, index) {
          final placeData = widget.placeList[index];
          return PlaceCard(
            placeData: placeData,
          );
        },
      ),
    );
  }
}