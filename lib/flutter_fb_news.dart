library flutter_fb_news;

// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:flutter_fb_news/flutter_fb_news_config.dart';
import 'fb_news_feed.dart';
import 'fb_news_service.dart';

/// Flutter plugin for displaying Facebook page feed with photos and videos
class FbNews extends StatefulWidget {
  /// [pageId] is required to identify the Facebook page, for example (253146702201895)
  final String pageId;

  /// [accesToken] is required to authorize for the Facebook Api
  /// Docu to get the authToken (https://developers.facebook.com/docs/facebook-login/access-tokens#pagetokens)
  final String accesToken;

  /// Limits the number of elements that are loaded
  ///
  /// #### DEFAULT = 20
  final int limit;

  // Customize the appearance of the posts
  final FbNewsConfig config;

  FbNews({
    required this.pageId,
    required this.accesToken,
    this.limit = 20,
    config,
  }) : config = config ?? FbNewsConfig();
  @override
  _FbNewsState createState() => _FbNewsState();
}

class _FbNewsState extends State<FbNews> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<http.Response>(
      future: FbNewsService.getProfilePicture(
        pageId: widget.pageId,
        token: widget.accesToken,
      ),
      builder: (context, snapshot1) {
        switch (snapshot1.connectionState) {
          case ConnectionState.waiting:
            return widget.config.waiting ??
                Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
          default:
            return hasErrors(snapshot1)
                ? widget.config.noDataOrError ??
                    Card(
                      color: Colors.red,
                      child: Text(
                        snapshot1.error as String? ?? snapshot1.data!.body,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                : new FutureBuilder<http.Response>(
                    future: FbNewsService.getFeed(
                      pageId: widget.pageId,
                      token: widget.accesToken,
                      limit: widget.limit,
                      fields: widget.config.fields,
                    ),
                    builder: (context, snapshot2) {
                      switch (snapshot2.connectionState) {
                        case ConnectionState.waiting:
                          return widget.config.waiting ??
                              Column(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                        default:
                          return hasErrors(snapshot2)
                              ? widget.config.noDataOrError ??
                                  Card(
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot2.error as String? ??
                                              snapshot2.data!.body,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              : FbNewsFeed(
                                  feedResponse: snapshot2.data!.body,
                                  profilePictureUrl: jsonDecode(
                                              snapshot1.data!.body)["picture"]
                                          ["data"]["url"]
                                      .toString(),
                                  config: widget.config,
                                );
                      }
                    },
                  );
        }
      },
    );
  }

  bool hasErrors(AsyncSnapshot<http.Response> snapshot) {
    return (!snapshot.hasData ||
        snapshot.hasError ||
        snapshot.data!.body.contains(
          "Exception",
        ));
  }
}

class FbNewsFields {
  @Deprecated(
    "use [attachmentsVideos] or [attachmentsPhotos]",
  )
  static final FbNewsFieldName attachments = FbNewsFieldName(
    "attachments",
    "attachments",
  );

  /// Enables the display of videos
  static final FbNewsFieldName attachmentsVideos = FbNewsFieldName(
    "attachments",
    "attachments_videos",
  );

  /// Enables the display of photos
  static final FbNewsFieldName attachmentsPhotos = FbNewsFieldName(
    "attachments",
    "attachments_photos",
  );

  /// Enables the display of shares
  static final FbNewsFieldName attachmentsShare = FbNewsFieldName(
    "attachments",
    "attachments_share",
  );

  /// Enables the display of shares
  static final FbNewsFieldName attachmentsVideoDirectResponseAutoplay =
      FbNewsFieldName(
    "attachments",
    "attachments_video_direct_response_autoplay",
  );

  /// Enables the display of messages
  static final FbNewsFieldName message = FbNewsFieldName(
    "message",
    "message",
  );

  /// Enables the display of headers
  static final FbNewsFieldName header = FbNewsFieldName(
    "message",
    "header",
  );

  /// Enables the display of footers
  static final FbNewsFieldName footer = FbNewsFieldName(
    "likes{id}",
    "footer",
  );
}

class FbNewsFieldName {
  /// Internal use to retrieve from the Facebook Api
  final String facebookKey;

  /// Internal use for handling internal widgets
  final String internalKey;
  FbNewsFieldName(
    this.facebookKey,
    this.internalKey,
  );
}
