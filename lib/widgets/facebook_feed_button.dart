import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FacebookFeedButton extends StatelessWidget {
  final Map<String, dynamic> feed;
  const FacebookFeedButton({
    @required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              DateTime.parse(
                feed["created_time"],
              ).toLocal().toString().substring(0, 16),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                Text(
                  feed["likes"]["data"].length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onPressed: () {
        launch(
          feed["permalink_url"],
        );
      },
    );
  }
}
