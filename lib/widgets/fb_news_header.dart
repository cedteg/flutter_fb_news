import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

class FbNewsHeader extends StatelessWidget {
  final Map<String, dynamic> feed;
  final String subtitle;

  @internal
  const FbNewsHeader({
    @required this.feed,
    @required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(feed["from"]["name"]),
      subtitle: Text(subtitle),
      onTap: () {
        launch(feed["permalink_url"]);
      },
    );
  }
}
