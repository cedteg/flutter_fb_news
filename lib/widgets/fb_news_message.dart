// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

class FbNewsMessage extends StatelessWidget {
  final Map<String, dynamic> feed;
  const FbNewsMessage({
    @required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return jsonEncode(feed).contains("message")
        ? Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              feed["message"],
            ),
          )
        : Container();
  }
}
