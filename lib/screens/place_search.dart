import 'dart:developer' as Developer;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pal_finder/data/place.dart';
import 'package:pal_finder/widgets/place_list.dart';
import 'package:pal_finder/widgets/search_bar.dart';
import 'package:pal_finder/core/networking.dart';

class PlaceSearchScreen extends StatefulWidget {
  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final String _placeSearchURL = '${Networking().host}/apis/places/textsearch/';
  final Networking _networking = Networking();
  final _placeList = <PlaceData>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextSubmitted(String text) async {
    Developer.log('Input: $text', name: 'pal_finder.emulator');
    try {
      final response = await _networking.get(Uri.parse(_placeSearchURL + '?query=' + text));
      final jsonData = jsonDecode(response.body)['results'];
      print(response.body);
      _placeList.clear();
      jsonData.forEach((result) {
        _placeList.add(PlaceData.fromMap(result));
      });
      setState(() {
        Developer.log('Place Search Tab state reset.', name: 'pal_finder.emulator');
      });
    } catch (err) {
      print(err);
    }
  }

  Widget _createSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
        onTextSubmitted: _onTextSubmitted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _createSearchBox(),
              Expanded(
                child: PlaceList(_placeList),
              ),
            ],
          ),
        ),
      ),
    );
  }
}