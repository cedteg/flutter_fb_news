# flutter_fb_news

A Package to display a facebook feed of a page

[![pub](https://img.shields.io/pub/v/flutter_fb_news.svg)](https://pub.dev/packages/flutter_fb_news)


# Using
```dart
import 'package:flutter_fb_news/flutter_fb_news.dart';

Center(
    child: FbNews(
        accesToken:"xyz", // Your Page AccesToken
        pageId: "123567890", // Your PageId
        limit: 25,
    ),
),
```
# Demo
![Demo](https://raw.githubusercontent.com/cedteg/flutter_fb_news/main/demo/flutter_fb_news-demo1.png)