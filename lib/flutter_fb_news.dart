library flutter_fb_news;

import 'package:flutter/material.dart';
import 'package:flutter_fb_news/fb_news_service.dart';
import 'package:http/http.dart' as http;

import 'widgets/fb_feed.dart';

/// Facebook News Feed of a facebook page like (https://www.facebook.com/Lohne-Longhorns-253146702201895/)
class FbNews extends StatefulWidget {
  /// [pageId] is required to identify the facebook page for example (253146702201895)
  final String pageId;

  /// [authToken] ist requred to authoried to the facebook api
  /// Docu to get the authToken (https://developers.facebook.com/docs/facebook-login/access-tokens#pagetokens)
  final String authToken;

  /// Limits the number of items that are loaded
  /// ## DEFAULT = 20
  final int limit;

  /// The [waiting] widget is displayed if the data is loading
  /// ## DEFAULT
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

  /// The [noDataOrError] widget ist displayed if the response has no data or an error
  ///
  /// ## DEFAULT
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

  const FbNews({
    @required this.pageId,
    @required this.authToken,
    this.limit,
    this.waiting,
    this.noDataOrError,
  });
  @override
  _FbNewsState createState() => _FbNewsState();
}

class _FbNewsState extends State<FbNews> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<http.Response>(
      future: FbNewsService().getFeed(
        pageId: widget.pageId,
        token: widget.authToken,
        limit: widget.limit ?? 20,
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
            if (!snapshot.hasData || snapshot.hasError)
              return widget.noDataOrError ??
                  Card(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.error.toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  );
            else
              return SingleChildScrollView(
                child: FacebookFeedNews(
                  feedResponse: snapshot.data.body,
                ),
              );
        }
      },
    );
  }
}
