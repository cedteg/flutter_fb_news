// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_slider.dart';

/// Only for internal use of flutter_fb_news
class FbNewsAttachmentsPhotos extends StatefulWidget {
  /// Only for internal use of flutter_fb_news
  final Map<String, dynamic> feed;

  const FbNewsAttachmentsPhotos({
    @required this.feed,
  });

  @override
  _FbNewsAttachmentsPhotosState createState() =>
      _FbNewsAttachmentsPhotosState();
}

class _FbNewsAttachmentsPhotosState extends State<FbNewsAttachmentsPhotos> {
  @override
  Widget build(BuildContext context) {
    var images = [];
    if (jsonEncode(widget.feed).contains("attachments")) {
      if (!jsonEncode(widget.feed).contains("subattachments")) {
        var attachments = widget.feed["attachments"]["data"];
        for (var attachment in attachments) {
          if (attachment["type"] == "photo") {
            images.add(attachment);
          }
        }
      } else {
        var subattachments =
            widget.feed["attachments"]["data"][0]["subattachments"]["data"];

        for (var attachment in subattachments) {
          if (attachment["type"] == "photo") {
            images.add(attachment);
          }
        }
      }
      return images.length > 0
          ? images.length > 1
              ? CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1.5,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  items: images
                      .map((i) {
                        return CachedNetworkImage(
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          imageUrl: i["media"]["image"]["src"] ?? "",
                        );
                      })
                      .cast<Widget>()
                      .toList(),
                )
              : Wrap(
                  children: images
                      .map((i) {
                        return CachedNetworkImage(
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          imageUrl: i["media"]["image"]["src"] ?? "",
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
