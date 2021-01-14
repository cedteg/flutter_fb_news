import 'package:flutter/material.dart';

class FbNewsFullPicture extends StatelessWidget {
  final Map<String, dynamic> feed;
  const FbNewsFullPicture({
    @required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !feed.toString().contains("subattachments") &&
              feed["full_picture"].toString() != "null"
          ? Image.network(
              feed["full_picture"].toString(),
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            )
          : Container(),
    );
  }
}
