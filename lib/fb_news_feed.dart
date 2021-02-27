// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_fb_news/fb_news_attachments_share.dart';
import 'package:flutter_fb_news/fb_news_attachments_video_direct_response_autoplay.dart';

// Project imports:
import 'fb_news_attachments_photos.dart';
import 'fb_news_attachments_videos.dart';
import 'fb_news_footer.dart';
import 'fb_news_header.dart';
import 'fb_news_message.dart';
import 'flutter_fb_news.dart';
import 'flutter_fb_news_config.dart';

/// Only for internal use of flutter_fb_news
class FbNewsFeed extends StatelessWidget {
  /// Only for internal use of flutter_fb_news
  final String feedResponse;

  /// Only for internal use of flutter_fb_news
  final String profilePictureUrl;

  /// Only for internal use of flutter_fb_news
  final FbNewsConfig config;

  const FbNewsFeed({
    @required this.feedResponse,
    @required this.profilePictureUrl,
    @required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return new Wrap(
      spacing: 20,
      runSpacing: 20,
      direction: Axis.horizontal,
      children: jsonDecode(feedResponse)["data"]
          .map(
            (feed) => config.showBorder
                ? Card(
                    color: config.borderColor ?? Theme.of(context).accentColor,
                    child: FbNewsFeedLayout(
                      config: config,
                      profilePictureUrl: profilePictureUrl,
                      feed: feed,
                    ),
                  )
                : FbNewsFeedLayout(
                    config: config,
                    profilePictureUrl: profilePictureUrl,
                    feed: feed,
                  ),
          )
          .cast<Widget>()
          .toList(),
    );
  }
}

class FbNewsFeedLayout extends StatelessWidget {
  /// Only for internal use of flutter_fb_news
  final Map<String, dynamic> feed;

  /// Only for internal use of flutter_fb_news
  final FbNewsConfig config;

  /// Only for internal use of flutter_fb_news
  final String profilePictureUrl;
  const FbNewsFeedLayout({
    @required this.feed,
    @required this.profilePictureUrl,
    @required this.config,
  });

  bool hasField(String internalKey) {
    return config.fields
        .where((element) => element.internalKey == internalKey)
        .isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460,
      padding: EdgeInsets.all(10),
      child: Card(
        color: config.backgroundColor,
        child: Column(
          children: [
            hasField(
              FbNewsFields.header.internalKey,
            )
                ? FbNewsHeader(
                    feed: feed,
                    profilePictureUrl: profilePictureUrl,
                    config: config,
                  )
                : Container(),
            hasField(
              FbNewsFields.message.internalKey,
            )
                ? FbNewsMessage(
                    feed: feed,
                    config: config,
                  )
                : Container(),
            hasField(
              FbNewsFields.attachmentsPhotos.internalKey,
            )
                ? FbNewsAttachmentsPhotos(
                    feed: feed,
                  )
                : Container(),
            hasField(
              FbNewsFields.attachmentsVideos.internalKey,
            )
                ? FbNewsAttachmentsVideos(
                    feed: feed,
                  )
                : Container(),
            hasField(
              FbNewsFields.attachmentsShare.internalKey,
            )
                ? FbNewsAttachmentsShares(
                    feed: feed,
                  )
                : Container(),
            hasField(
              FbNewsFields.attachmentsVideoDirectResponseAutoplay.internalKey,
            )
                ? FbNewsAttachmentsVideoDirectResponseAutoplay(
                    feed: feed,
                  )
                : Container(),
            hasField(
              FbNewsFields.footer.internalKey,
            )
                ? FbNewsFooter(
                    feed: feed,
                    config: config,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
