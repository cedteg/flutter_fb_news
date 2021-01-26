// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

/// Only for internal use of flutter_fb_news
class FbNewsFooter extends StatelessWidget {
  /// Only for internal use of flutter_fb_news
  final Map<String, dynamic> feed;

  /// Only for internal use of flutter_fb_news
  final Color textColor;
  const FbNewsFooter({
    @required this.feed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: feed["likes"] == null
          ? null
          : Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.thumb_up,
                  color: textColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  feed["likes"]["data"].length.toString(),
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ],
            ),
      trailing: Text(
        DateTime.parse(feed["created_time"])
            .toLocal()
            .toString()
            .substring(0, 16),
        style: TextStyle(
          color: textColor,
        ),
      ),
      onTap: () {
        launch(feed["permalink_url"]);
      },
    );
  }
}
