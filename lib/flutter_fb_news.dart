library flutter_fb_news;

import 'package:flutter/material.dart';
import 'package:flutter_fb_news/fb_news_service.dart';
import 'package:http/http.dart' as http;

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
      future: FbNewsService.getFeed(
        pageId: widget.pageId,
        token: widget.accesToken,
        limit: widget.limit,
        fields: widget.fields,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
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
            if (!snapshot.hasData ||
                snapshot.hasError ||
                snapshot.data.body.contains(
                  "Exception",
                ))
              return widget.noDataOrError ??
                  Card(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.error ?? snapshot.data.body,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  );
            else
              return FbNewsFeed(
                feedResponse: snapshot.data.body,
                subtitle: widget.subtitle,
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
