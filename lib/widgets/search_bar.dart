import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  SearchBar({
    @required this.controller,
    @required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color.fromRGBO(75, 0, 130, 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Row(
          children: [
            ExcludeSemantics(
              child: Icon(
                CupertinoIcons.search,
                color: Color.fromRGBO(128, 128, 128, 1.0),
              ),
            ),
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                cursorColor: Color.fromRGBO(10, 10, 10, 1.0),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.clear();
              },
              child: Icon(
                CupertinoIcons.clear_thick_circled,
                semanticLabel: 'Clear search terms',
                color: Color.fromRGBO(128, 128, 128, 1.0)
              ),
            ),
          ],
        ),
      ),
    );
  }
}