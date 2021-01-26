// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../flutter_fb_news.dart';
import 'fb_news_attachments_photos.dart';
import 'fb_news_attachments_videos.dart';
import 'fb_news_footer.dart';
import 'fb_news_header.dart';
import 'fb_news_message.dart';

/// Only for internal use of flutter_fb_news
class FbNewsFeed extends StatelessWidget {
  /// Only for internal use of flutter_fb_news
  final String subtitle;

  /// Only for internal use of flutter_fb_news
  final String feedResponse;

  /// Only for internal use of flutter_fb_news
  final String profilePictureUrl;

  /// Only for internal use of flutter_fb_news
  final List<FbNewsFieldName> fields;

  /// Only for internal use of flutter_fb_news
  final Color borderColor;

  /// Only for internal use of flutter_fb_news
  final Color backgroundColor;

  /// Only for internal use of flutter_fb_news
  final Color textColor;

  const FbNewsFeed({
    @required this.feedResponse,
    @required this.subtitle,
    @required this.profilePictureUrl,
    @required this.fields,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
  });

  bool hasField(String internalKey) {
    return fields
        .where((element) => element.internalKey == internalKey)
        .isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return new Wrap(
      spacing: 20,
      runSpacing: 20,
      direction: Axis.horizontal,
      children: jsonDecode(feedResponse)["data"]
          .map(
            (feed) => Card(
              color: borderColor ?? Theme.of(context).accentColor,
              child: Container(
                width: 460,
                padding: EdgeInsets.all(10),
                child: Card(
                  color: backgroundColor,
                  child: Container(
                    width: 430,
                    child: Column(
                      children: [
                        hasField(
                          FbNewsFields.header.internalKey,
                        )
                            ? FbNewsHeader(
                                subtitle: subtitle,
                                feed: feed,
                                profilePictureUrl: profilePictureUrl,
                                textColor: textColor,
                              )
                            : Container(),
                        hasField(
                          FbNewsFields.message.internalKey,
                        )
                            ? FbNewsMessage(
                                feed: feed,
                                textColor: textColor,
                              )
                            : Container(),
                        hasField(
                                  "attachments",
                                ) ||
                                hasField(
                                  FbNewsFields.attachmentsPhotos.internalKey,
                                )
                            ? FbNewsAttachmentsPhotos(
                                feed: feed,
                              )
                            : Container(),
                        hasField(
                                  "attachments",
                                ) ||
                                hasField(
                                  FbNewsFields.attachmentsVideos.internalKey,
                                )
                            ? FbNewsAttachmentsVideos(
                                feed: feed,
                              )
                            : Container(),
                        hasField(
                          FbNewsFields.footer.internalKey,
                        )
                            ? FbNewsFooter(
                                feed: feed,
                                textColor: textColor,
                              )
                            : Container(),
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
