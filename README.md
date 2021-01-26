# flutter_fb_news

Flutter plugin for displaying Facebook page feed with photos and videos

[![pub](https://img.shields.io/pub/v/flutter_fb_news.svg)](https://pub.dev/packages/flutter_fb_news)


# Using
```dart
import 'package:flutter_fb_news/flutter_fb_news.dart';

Center(
    child: FbNews(
        accesToken:"xyz", // Your Page AccesToken
        pageId: "123567890", // Your PageId
        limit: 25,
        fields: [
            FbNewsFields.header,
            FbNewsFields.attachmentsPhotos,
            FbNewsFields.attachmentsVideos,
            FbNewsFields.message,
            FbNewsFields.footer,
        ]
    ),
),
```
# Demo
![Demo](https://raw.githubusercontent.com/cedteg/flutter_fb_news/main/demo/flutter_fb_news-demo1.png)