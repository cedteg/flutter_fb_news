// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:meta/meta.dart';

// Project imports:
import 'fb_news_attachments.dart';
import 'fb_news_footer.dart';
import 'fb_news_header.dart';
import 'fb_news_message.dart';

class FbNewsFeed extends StatelessWidget {
  final String subtitle;
  final String feedResponse;
  final String profilePictureUrl;

  @internal
  const FbNewsFeed({
    @required this.feedResponse,
    @required this.subtitle,
    @required this.profilePictureUrl,
  });
  @override
  Widget build(BuildContext context) {
    return new Wrap(
      spacing: 20,
      runSpacing: 20,
      direction: Axis.horizontal,
      children: jsonDecode(feedResponse)["data"]
          .map(
            (feed) => Card(
              color: Theme.of(context).accentColor,
              child: Container(
                width: 460,
                padding: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    width: 430,
                    child: Column(
                      children: [
                        FbNewsHeader(
                          subtitle: subtitle,
                          feed: feed,
                          profilePictureUrl: profilePictureUrl,
                        ),
                        FbNewsMessage(
                          feed: feed,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FbNewsAttachments(
                          feed: feed,
                        ),
                        FbNewsFooter(
                          feed: feed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .cast<Widget>()
          .toList(),
    );
  }
}
