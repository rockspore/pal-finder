import 'dart:developer' as Developer;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pal_finder/data/place.dart';
import 'package:pal_finder/widgets/place_list.dart';
import 'package:pal_finder/widgets/search_bar.dart';

class PlaceSearchScreen extends StatefulWidget {
  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final String _placeSearchURL = 'http://10.0.2.2:8000/apis/places/textsearch/';
  final String token = 'Token cbfae62f222ea02664cd84f7964b64998c2fabde';
  final HttpClient httpClient = HttpClient();
  final _placeList = <PlaceData>[];

  @override
  void initState() {
    _getDummyData();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
    httpClient.close();
  }

  void _getDummyData() {
    final String jsonString = '{"html_attributions":[],"results":[{"formatted_address":"North Ave NW, Atlanta, GA 30332, United States","geometry":{"location":{"lat":33.7756178,"lng":-84.39628499999999},"viewport":{"northeast":{"lat":33.78656400000001,"lng":-84.37895280000001},"southwest":{"lat":33.76633560000001,"lng":-84.41260639999999}}},"icon":"https://maps.gstatic.com/mapfiles/place_api/icons/school-71.png","id":"1b84da9492645ad3413c4429ec4f70f7b7cbcb39","name":"Georgia Institute of Technology","opening_hours":{"open_now":false},"photos":[{"height":3024,"photo_reference":"CmRaAAAAgDkK25u2orZpEbBUq4XSvVWtmxKEbW34VLS8uJdaB0qwCXFluhfIIro8QUNjFVOvuGVFG_PkxraM6lrEHKKnW6chbEtY08uzZj25m8tJINqv6pXbdgYT1fJEP_-TjykMEhAvHsc8szFJFqPUalbRqmT8GhRadeDYuANtwFgH-8j9PDIHvnMl_g","width":4032}],"place_id":"ChIJ40_D64oE9YgRD8XYOj7QKrU","plus_code":{"compound_code":"QJG3+6F Atlanta, Georgia","global_code":"865QQJG3+6F"},"rating":4.5,"reference":"ChIJ40_D64oE9YgRD8XYOj7QKrU","user_ratings_total":535}],"status":"OK"}';
    var jsonData = jsonDecode(jsonString);
    jsonData = jsonData['results'] as List;
    jsonData.forEach((item) {
      _placeList.add(PlaceData.fromMap(item));
    });
  }

  void _onTextSubmitted(String text) async {
    Developer.log('Input: $text', name: 'pal_finder.emulator');
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(_placeSearchURL + '?query=$text'));
    request.headers.add(HttpHeaders.authorizationHeader, token);
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
    HttpClientResponse response = await request.close();
    String reply = await response.transform(Utf8Decoder()).join();
    final jsonData = jsonDecode(reply)['results'] as List;
    _placeList.clear();
    jsonData.forEach((result) {
      _placeList.add(PlaceData.fromMap(result as Map));
    });
    setState(() {
      Developer.log('Place Search Tab state reset.', name: 'pal_finder.emulator');
    });
  }

  Widget _createSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: controller,
        focusNode: focusNode,
        onTextSubmitted: _onTextSubmitted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromRGBO(1, 1, 1, 0.0),
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