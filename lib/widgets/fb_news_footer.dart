// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

class FbNewsFooter extends StatelessWidget {
  final Map<String, dynamic> feed;
  const FbNewsFooter({
    @required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            Icons.thumb_up,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            feed["likes"]["data"].length.toString(),
          ),
        ],
      ),
      trailing: Text(
        DateTime.parse(feed["created_time"])
            .toLocal()
            .toString()
            .substring(0, 16),
      ),
      onTap: () {
        launch(feed["permalink_url"]);
      },
    );
  }
}
