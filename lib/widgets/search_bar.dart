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
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: Icon(
              Icons.clear,
              color: Colors.grey,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search',
          contentPadding: EdgeInsets.only(
              left: 14.0, bottom: 14.0, top: 14.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        controller: controller,
        focusNode: focusNode,
        cursorColor: Colors.grey,
        onSubmitted: onTextSubmitted,
      ),
    );
  }
}