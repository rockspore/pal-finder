import 'dart:developer' as Developer;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pal_finder/screens/event_list.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void _onTextSubmitted(String text) async {
    Developer.log('Input: $text', name: 'pal_finder.emulator');
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(_placeSearchURL + '?query=$text'));
    request.headers.add(HttpHeaders.authorizationHeader, token);
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
    HttpClientResponse response = await request.close();
    String reply = await response.transform(Utf8Decoder()).join();
    var map = jsonDecode(reply);
    for (Map result in map['results']) {
      print(result['name']);
      print(result['geometry']);
      print(result['icon']);
    }
    httpClient.close();
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
    return CupertinoTabView(
      builder: (context) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Color.fromRGBO(1, 1, 1, 0.0),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _createSearchBox(),
                Expanded(
                  child: EventList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}