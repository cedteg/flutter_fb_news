// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

class FbNewsHeader extends StatelessWidget {
  final Map<String, dynamic> feed;
  final String subtitle;
  final String profilePictureUrl;

  @internal
  const FbNewsHeader({
    @required this.feed,
    @required this.subtitle,
    @required this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        profilePictureUrl,
      ),
      title: Text(
        feed["from"]["name"],
      ),
      subtitle: Text(
        subtitle,
      ),
      onTap: () {
        launch(
          feed["permalink_url"],
        );
      },
    );
  }
}
