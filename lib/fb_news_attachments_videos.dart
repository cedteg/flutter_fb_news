// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'fb_news_attachments_video.dart';

/// Only for internal use of flutter_fb_news
class FbNewsAttachmentsVideos extends StatefulWidget {
  /// Only for internal use of flutter_fb_news
  final Map<String, dynamic> feed;

  const FbNewsAttachmentsVideos({
    @required this.feed,
  });

  @override
  _FbNewsAttachmentsVideosState createState() =>
      _FbNewsAttachmentsVideosState();
}

class _FbNewsAttachmentsVideosState extends State<FbNewsAttachmentsVideos> {
  @override
  Widget build(BuildContext context) {
    var videos = [];
    if (jsonEncode(widget.feed).contains("attachments")) {
      if (!jsonEncode(widget.feed).contains("subattachments")) {
        var attachments = widget.feed["attachments"]["data"];
        for (var attachment in attachments) {
          if (attachment["type"].contains("video")) {
            videos.add(attachment);
          }
        }
      } else {
        var subattachments =
            widget.feed["attachments"]["data"][0]["subattachments"]["data"];

        for (var attachment in subattachments) {
          if (attachment["type"].contains("video")) {
            videos.add(attachment);
          }
        }
      }
      return videos.length > 0
          ? Wrap(
              children: videos
                  .map((v) {
                    return FbNewsAttachmentsVideo(
                      videourl: v["media"]["source"] ?? "",
                    );
                  })
                  .cast<Widget>()
                  .toList(),
            )
          : Container();
    } else {
      return Container();
    }
  }
}
