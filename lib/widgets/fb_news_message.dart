// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

/// Only for internal use of flutter_fb_news
class FbNewsMessage extends StatelessWidget {
  /// Only for internal use of flutter_fb_news
  final Map<String, dynamic> feed;

  /// Only for internal use of flutter_fb_news
  final Color textColor;

  /// Only for internal use of flutter_fb_news
  const FbNewsMessage({
    @required this.feed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return jsonEncode(feed).contains("message")
        ? Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              feed["message"],
              style: TextStyle(
                color: textColor,
              ),
            ),
          )
        : Container();
  }
}
