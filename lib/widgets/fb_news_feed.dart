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

class FbNewsFeed extends StatelessWidget {
  final String subtitle;
  final String feedResponse;
  final String profilePictureUrl;
  final List<FbNewsFieldName> fields;

  const FbNewsFeed({
    @required this.feedResponse,
    @required this.subtitle,
    @required this.profilePictureUrl,
    @required this.fields,
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
              color: Theme.of(context).accentColor,
              child: Container(
                width: 460,
                padding: EdgeInsets.all(10),
                child: Card(
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
                              )
                            : Container(),
                        hasField(
                          FbNewsFields.message.internalKey,
                        )
                            ? FbNewsMessage(
                                feed: feed,
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
