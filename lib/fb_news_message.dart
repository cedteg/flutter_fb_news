// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'flutter_fb_news_config.dart';

/// Only for internal use of flutter_fb_news
class FbNewsMessage extends StatelessWidget {
  /// Only for internal use of flutter_fb_news
  final Map<String, dynamic> feed;

  /// Only for internal use of flutter_fb_news
  final FbNewsConfig config;

  /// Only for internal use of flutter_fb_news
  const FbNewsMessage({
    @required this.feed,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    return jsonEncode(feed).contains("message")
        ? Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Linkify(
              onOpen: (link) {
                launch(
                  link.url,
                );
              },
              text: feed["message"],
              style: TextStyle(
                color: config.textColor,
              ),
              linkStyle: TextStyle(
                color: config.linkColor,
              ),
            ),
          )
        : Container();
  }
}
