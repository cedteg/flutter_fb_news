// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'fb_news_attachments_video.dart';

/// Only for internal use of flutter_fb_news
class FbNewsAttachmentsVideoDirectResponse extends StatefulWidget {
  /// Only for internal use of flutter_fb_news
  final Map<String, dynamic> feed;

  const FbNewsAttachmentsVideoDirectResponse({
    required this.feed,
  });

  @override
  _FbNewsAttachmentsVideoDirectResponseState createState() =>
      _FbNewsAttachmentsVideoDirectResponseState();
}

class _FbNewsAttachmentsVideoDirectResponseState
    extends State<FbNewsAttachmentsVideoDirectResponse> {
  @override
  Widget build(BuildContext context) {
    var _attachment = [];
    if (jsonEncode(widget.feed).contains("attachments")) {
      if (!jsonEncode(widget.feed).contains("subattachments")) {
        var attachments = widget.feed["attachments"]["data"];
        for (var attachment in attachments) {
          if (attachment["type"] == "video_direct_response_autoplay" ||
              attachment["type"] == "video_direct_response") {
            _attachment.add(attachment);
          }
        }
      } else {
        var subattachments =
            widget.feed["attachments"]["data"][0]["subattachments"]["data"];

        for (var attachment in subattachments) {
          if (attachment["type"] == "video_direct_response_autoplay" ||
              attachment["type"] == "video_direct_response") {
            _attachment.add(attachment);
          }
        }
      }
      return _attachment.length > 0
          ? Wrap(
              children: _attachment
                  .map((v) {
                    if (v["media"]["source"] != null) {
                      return FbNewsAttachmentsVideo(
                        videourl: v["media"]["source"] ?? "",
                      );
                    }
                    if (v["media"]["image"]["src"] != null) {
                      return Column(
                        children: [
                          CachedNetworkImage(
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            imageUrl: v["media"]["image"]["src"] ?? "",
                          ),
                          v["description"] != null || v["title"] != null
                              ? ListTile(
                                  onTap: () {
                                    launch(v["url"]);
                                  },
                                  leading: Icon(
                                    Icons.open_in_browser,
                                  ),
                                  title: v["title"] != null
                                      ? Text(
                                          v["title"],
                                        )
                                      : null,
                                  subtitle: v["description"] != null
                                      ? Linkify(
                                          text: v["description"],
                                        )
                                      : null,
                                )
                              : Container(),
                        ],
                      );
                    }
                    return Container();
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
