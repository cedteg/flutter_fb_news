// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:flutter_fb_news/flutter_fb_news_config.dart';

/// Only for internal use of flutter_fb_news
class FbNewsHeader extends StatelessWidget {
  /// Only for internal use of flutter_fb_news
  final Map<String, dynamic> feed;

  /// Only for internal use of flutter_fb_news
  final String profilePictureUrl;
  // Customize the appearance of the posts
  final FbNewsConfig config;

  const FbNewsHeader({
    @required this.feed,
    @required this.profilePictureUrl,
    @required this.config,
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
          color: config.textColor,
        ),
      ),
      subtitle: Text(
        config.subtitle,
        style: TextStyle(
          color: config.textColor,
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
