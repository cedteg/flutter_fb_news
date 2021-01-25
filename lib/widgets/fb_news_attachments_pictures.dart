// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FbNewsAttachmentsPictures extends StatelessWidget {
  final Map<String, dynamic> feed;

  const FbNewsAttachmentsPictures({
    @required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return feed.toString().contains("subattachments")
        ? CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: feed["attachments"]["data"][0]["subattachments"]["data"]
                .map(
                  (subattachment) => Image.network(
                    subattachment["media"]["image"]["src"],
                  ),
                )
                .cast<Widget>()
                .toList(),
          )
        : Container();
  }
}
