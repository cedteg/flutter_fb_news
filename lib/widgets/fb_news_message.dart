import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FbNewsMessage extends StatelessWidget {
  @internal
  final Map<String, dynamic> feed;
  const FbNewsMessage({
    @required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return feed.toString().contains("message")
        ? Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              feed["message"],
            ),
          )
        : Container();
  }
}
