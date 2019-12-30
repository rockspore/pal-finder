import 'dart:developer' as Developer;
import 'package:flutter/cupertino.dart';
import 'package:pal_finder/screens/event_list.dart';
import 'package:pal_finder/widgets/search_bar.dart';

class PlaceSearchScreen extends StatefulWidget {
  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
//    controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

//  void _onTextChanged() {
//    // setState(() => {});
//  }

  void _onTextSubmitted(String text) {
    // TODO: implement the request to get nearby places
    Developer.log('Input: ' + text, name: "pal_finder.emulator");
    // setState(() => {});
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