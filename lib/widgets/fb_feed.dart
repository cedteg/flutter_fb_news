import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'facebook_attachments_pictures.dart';
import 'facebook_full_picture.dart';

class FacebookFeedNews extends StatelessWidget {
  final String feedResponse;

  const FacebookFeedNews({
    @required this.feedResponse,
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
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(feed["from"]["name"]),
                          subtitle: Text("von Facebook"),
                          onTap: () {
                            launch(feed["permalink_url"]);
                          },
                        ),
                        Text(
                          feed["message"],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FbAttachmentsPictures(
                          feed: feed,
                        ),
                        FbFullPicture(
                          feed: feed,
                        ),
                        ListTile(
                          leading: Wrap(
                            children: [
                              Icon(
                                Icons.thumb_up,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                feed["likes"]["data"].length.toString(),
                              ),
                            ],
                          ),
                          trailing: Text(
                            DateTime.parse(feed["created_time"])
                                .toLocal()
                                .toString()
                                .substring(0, 16),
                          ),
                          onTap: () {
                            launch(feed["permalink_url"]);
                          },
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
