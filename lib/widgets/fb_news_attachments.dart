// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_slider.dart';

// Project imports:
import 'fb_news_attachments_video.dart';

class FbNewsAttachments extends StatefulWidget {
  final Map<String, dynamic> feed;

  const FbNewsAttachments({
    @required this.feed,
  });

  @override
  _FbNewsAttachmentsState createState() => _FbNewsAttachmentsState();
}

class _FbNewsAttachmentsState extends State<FbNewsAttachments> {
  @override
  Widget build(BuildContext context) {
    var videos = [];
    var images = [];
    if (widget.feed.toString().contains("attachments") &&
        !widget.feed.toString().contains("subattachments")) {
      var attachments = widget.feed["attachments"]["data"];
      for (var attachment in attachments) {
        if (attachment["type"].contains("video")) {
          videos.add(attachment);
        } else if (attachment["type"] == "photo") {
          images.add(attachment);
        }
      }
    } else {
      var subattachments =
          widget.feed["attachments"]["data"][0]["subattachments"]["data"];

      for (var attachment in subattachments) {
        if (attachment["type"].contains("video")) {
          videos.add(attachment);
        } else if (attachment["type"] == "photo") {
          images.add(attachment);
        }
      }
    }
    return Wrap(
      children: [
        images.length > 0
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
                          return Image.network(
                            i["media"]["image"]["src"] ?? "",
                          );
                        })
                        .cast<Widget>()
                        .toList(),
                  )
                : Wrap(
                    children: images
                        .map((i) {
                          return Image.network(
                            i["media"]["image"]["src"] ?? "",
                          );
                        })
                        .cast<Widget>()
                        .toList(),
                  )
            : Container(),
        videos.length > 0
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
            : Container(),
      ],
    );
  }
}
