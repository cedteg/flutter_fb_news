library flutter_fb_news;

// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'fb_news_service.dart';
import 'widgets/fb_news_feed.dart';

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

  /// The [waiting] widget is displayed when the data is loaded
  ///
  /// #### DEFAULT
  /// ```dart
  /// Column(
  ///   children: [
  ///       CircularProgressIndicator(),
  ///       SizedBox(
  ///           height: 10,
  ///       )
  ///   ],
  /// );
  /// ```
  final Widget waiting;

  /// The [noDataOrError] widget is displayed if the response contains no data or an error
  ///
  /// #### DEFAULT
  /// ```dart
  /// Card(
  ///   color: Colors.red,
  ///    child: Row(
  ///       mainAxisAlignment: MainAxisAlignment.center,
  ///       children: [
  ///           Text(
  ///               snapshot.error.toString(),
  ///               style: TextStyle(
  ///                   color: Colors.white,
  ///               ),
  ///           )
  ///       ],
  ///   ),
  /// );
  /// ```
  final Widget noDataOrError;

  /// #### Supported fields are
  /// ```dart
  /// [
  ///   FbNewsFields.header,
  ///   FbNewsFields.attachmentsPhotos,
  ///   FbNewsFields.attachmentsVideos,
  ///   FbNewsFields.message,
  ///   FbNewsFields.footer,
  /// ];
  /// ```
  ///
  /// #### DEFAULT
  /// ```dart
  /// [
  ///   FbNewsFields.attachments,
  ///   FbNewsFields.message,
  /// ];
  /// ```
  final List<FbNewsFieldName> fields;

  /// Subtitle in the every feeditem
  final String subtitle;

  /// Set the Color of the border
  ///
  /// #### DEFAULT
  /// Theme.of(context).accentColor
  final Color borderColor;

  /// Set the Color of the background
  ///
  /// #### DEFAULT
  /// If this property is null then [CardTheme.color] of [ThemeData.cardTheme]
  /// is used. If that's null then [ThemeData.cardColor] is used.
  final Color backgroundColor;

  /// Set the Color of the text
  final Color textColor;

  FbNews({
    @required this.pageId,
    @required this.accesToken,
    this.limit = 20,
    this.waiting,
    this.noDataOrError,
    this.subtitle = "von Facebook",
    this.borderColor,
    fields,
    this.backgroundColor,
    this.textColor,
  }) : fields = fields ??
            [
              FbNewsFields.header,
              FbNewsFields.attachmentsPhotos,
              FbNewsFields.attachmentsVideos,
              FbNewsFields.message,
              FbNewsFields.footer,
            ];
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
            return widget.waiting ??
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
                ? widget.noDataOrError ??
                    Card(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot1.error ?? snapshot1.data.body,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    )
                : new FutureBuilder<http.Response>(
                    future: FbNewsService.getFeed(
                      pageId: widget.pageId,
                      token: widget.accesToken,
                      limit: widget.limit,
                      fields: widget.fields,
                    ),
                    builder: (context, snapshot2) {
                      switch (snapshot2.connectionState) {
                        case ConnectionState.waiting:
                          return widget.waiting ??
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
                              ? widget.noDataOrError ??
                                  Card(
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot2.error ??
                                              snapshot2.data.body,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              : FbNewsFeed(
                                  feedResponse: snapshot2.data.body,
                                  profilePictureUrl:
                                      jsonDecode(snapshot1.data.body)["picture"]
                                              ["data"]["url"]
                                          .toString(),
                                  subtitle: widget.subtitle,
                                  fields: widget.fields,
                                  borderColor: widget.borderColor,
                                  backgroundColor: widget.backgroundColor,
                                  textColor: widget.textColor,
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
        snapshot.data.body.contains(
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
