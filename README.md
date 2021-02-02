# flutter_fb_news

Flutter plugin for displaying Facebook page feed with photos and videos

[![platform](https://img.shields.io/badge/Platform-Flutter-blue.svg)](https://flutter.dev/)
[![pub](https://img.shields.io/pub/v/flutter_fb_news.svg)](https://pub.dev/packages/flutter_fb_news)
[![donate](https://img.shields.io/badge/Donate-Buy%20me%20a%20coffe-yellow.svg)](https://www.buymeacoffee.com/cedtegapps)

# Getting Started
You should ensure that you add the `flutter_fb_news` as a dependency in your flutter project.
```
dependencies:
  flutter_fb_news: '^1.1.1'
```

You should then run `flutter packages get` in your terminal so as to get the package.

# Using
```dart
import 'package:flutter_fb_news/flutter_fb_news.dart';

Center(
    child: FbNews(
        accesToken:"xyz",
        pageId: "123567890",
        limit: 25,
        config: FbNewsConfig(
            subtitle = "from Facebook",
            waiting: Column(
                children: [
                    CircularProgressIndicator(),
                    SizedBox(
                        height: 10,
                    )
                ],
            ),
            noDataOrError: Card(
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
            ),
            fields: [
                FbNewsFields.header,
                FbNewsFields.attachmentsPhotos,
                FbNewsFields.attachmentsVideos,
                FbNewsFields.message,
                FbNewsFields.footer,
            ],
            borderColor: Colors.black,
            showBorder = true,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            linkColor: Colors.blue,
        ),
    ),
),
```

# Demo
![Demo](https://raw.githubusercontent.com/cedteg/flutter_fb_news/main/demo/flutter_fb_news-demo1.png)

# Parameters

| Parameter | Type  | Required | Description |
| ---- | ---- | ---- | ---- | ---- |
| `pageId` | String  | yes | is required to identify the Facebook page, for example (253146702201895)| 
| `accesToken` | String  | yes |is required to authorize for the Facebook Api Docu to get the authToken https://developers.facebook.com/docs/facebook-login/access-tokens#pagetokens| 
| `limit` | int  | no | Limits the number of elements that are loaded Default: 20| 
| `config` | FbNewsConfig | no | Customize the appearance of the posts| 


## FbNewsConfig Params

| Parameter | Type  | Required | Description |
| ---- | ---- | ----  | ---- |
| `subtitle` | String  | no | Subtitle in the every feeditem Default: "von Facebook" | 
| `waiting` | Widget | no | The `waiting` widget is displayed when the data is loaded | 
| `noDataOrError` | Widget  | no | The `noDataOrError`widget is displayed if the response contains no data or an error | 
| `fields` | List<FbNewsFieldName>  | no | Select which fields to display | 
| `borderColor` | Color  | no | Set the Color of the border | 
| `showBorder` | Boolean  | no |Toogle the display of the border | 
| `backgroundColor` | Color  | no |  Set the Color of the background | 
| `textColor` | Color  | no | Set the Color of the text | 
| `linkColor` | Color  | no | Set the Color of a link | 
