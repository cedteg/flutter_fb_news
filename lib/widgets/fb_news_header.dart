// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

/// Only for internal use of flutter_fb_news
class FbNewsHeader extends StatelessWidget {
  /// Only for internal use of flutter_fb_news
  final Map<String, dynamic> feed;

  /// Only for internal use of flutter_fb_news
  final String subtitle;

  /// Only for internal use of flutter_fb_news
  final String profilePictureUrl;

  /// Only for internal use of flutter_fb_news
  final Color textColor;

  const FbNewsHeader({
    @required this.feed,
    @required this.subtitle,
    @required this.profilePictureUrl,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        profilePictureUrl,
      ),
      title: Text(
        feed["from"]["name"],
        style: TextStyle(
          color: textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: textColor,
        ),
      ),
      onTap: () {
        launch(
          feed["permalink_url"],
        );
      },
    );
  }
}
