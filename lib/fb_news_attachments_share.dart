// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

/// Only for internal use of flutter_fb_news
class FbNewsAttachmentsShares extends StatefulWidget {
  /// Only for internal use of flutter_fb_news
  final Map<String, dynamic> feed;

  const FbNewsAttachmentsShares({
    required this.feed,
  });

  @override
  _FbNewsAttachmentsSharesState createState() =>
      _FbNewsAttachmentsSharesState();
}

class _FbNewsAttachmentsSharesState extends State<FbNewsAttachmentsShares> {
  @override
  Widget build(BuildContext context) {
    var images = [];
    if (jsonEncode(widget.feed).contains("attachments")) {
      if (!jsonEncode(widget.feed).contains("subattachments")) {
        var attachments = widget.feed["attachments"]["data"];
        for (var attachment in attachments) {
          if (attachment["type"] == "share") {
            images.add(attachment);
          }
        }
      } else {
        var subattachments =
            widget.feed["attachments"]["data"][0]["subattachments"]["data"];

        for (var attachment in subattachments) {
          if (attachment["type"] == "share") {
            images.add(attachment);
          }
        }
      }
      return images.length > 0
          ? Wrap(
              runSpacing: 20,
              spacing: 20,
              children: images
                  .map((i) {
                    return Column(
                      children: [
                        CachedNetworkImage(
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          imageUrl: i["media"]["image"]["src"] ?? "",
                        ),
                        i["description"] != null || i["title"] != null
                            ? ListTile(
                                onTap: () {
                                  launch(i["url"]);
                                },
                                leading: Icon(
                                  Icons.open_in_browser,
                                ),
                                title: i["title"] != null
                                    ? Text(
                                        i["title"],
                                      )
                                    : null,
                                subtitle: i["description"] != null
                                    ? Linkify(
                                        text: i["description"],
                                      )
                                    : null,
                              )
                            : Container(),
                      ],
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
