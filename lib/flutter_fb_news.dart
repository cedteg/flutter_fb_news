library flutter_fb_news;

import 'package:flutter/material.dart';
import 'package:flutter_fb_news/fb_news_service.dart';
import 'package:http/http.dart' as http;

import 'widgets/fb_feed.dart';

class FbNews extends StatefulWidget {
  final String pageID;
  final String token;

  const FbNews({
    this.pageID,
    this.token,
  });
  @override
  _FbNewsState createState() => _FbNewsState();
}

class _FbNewsState extends State<FbNews> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<http.Response>(
      future: FbNewsService().getFeed(
        pageId: widget.pageID,
        token: widget.token,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                )
              ],
            );
          default:
            if (!snapshot.hasData)
              return Card(
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
              return FacebookFeedNews(
                feedResponse: snapshot.data.body,
              );
        }
      },
    );
  }
}
