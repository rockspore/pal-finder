// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onTextSubmitted;

  SearchBar({
    @required this.controller,
    @required this.focusNode,
    @required this.onTextSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 8,
      ),
      child: Row(
        children: [
          ExcludeSemantics(
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search',
                contentPadding: EdgeInsets.only(
                    left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white),
                  borderRadius: new BorderRadius.circular(100),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white),
                  borderRadius: new BorderRadius.circular(100),
                ),
              ),
              controller: controller,
              focusNode: focusNode,
              cursorColor: Colors.grey,
              onSubmitted: onTextSubmitted,
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.clear();
            },
            child: Icon(
              Icons.clear,
              semanticLabel: 'Clear search terms',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}