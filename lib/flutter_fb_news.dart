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
  ///   FbNewsFields.attachments,
  ///   FbNewsFields.message,
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

  FbNews({
    @required this.pageId,
    @required this.accesToken,
    this.limit = 20,
    this.waiting,
    this.noDataOrError,
    this.subtitle = "von Facebook",
    fields,
  }) : fields = fields ??
            [
              FbNewsFields.attachments,
              FbNewsFields.message,
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
            if (!snapshot1.hasData ||
                snapshot1.hasError ||
                snapshot1.data.body.contains(
                  "Exception",
                ))
              return widget.noDataOrError ??
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
                  );
            else
              return new FutureBuilder<http.Response>(
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
                      if (!snapshot2.hasData ||
                          snapshot2.hasError ||
                          snapshot2.data.body.contains(
                            "Exception",
                          ))
                        return widget.noDataOrError ??
                            Card(
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot2.error ?? snapshot2.data.body,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                      else
                        return FbNewsFeed(
                          feedResponse: snapshot2.data.body,
                          profilePictureUrl:
                              jsonDecode(snapshot1.data.body)["picture"]["data"]
                                      ["url"]
                                  .toString(),
                          subtitle: widget.subtitle,
                        );
                  }
                },
              );
        }
      },
    );
  }
}

class FbNewsFields {
  static final FbNewsFieldName attachments = FbNewsFieldName("attachments");
  static final FbNewsFieldName message = FbNewsFieldName("message");
}

class FbNewsFieldName {
  final String name;

  FbNewsFieldName(
    this.name,
  );
}
