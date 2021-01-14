import 'package:flutter/material.dart';
import 'package:flutter_fb_news/flutter_fb_news.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_fb_news example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter_fb_news example"),
      ),
      body: Center(
        child: FbNews(
          accesToken: "xzy",
          pageId: "123567890",
          limit: 25,
          fields: [
            FbNewsFields.attachments,
            FbNewsFields.fullPicture,
            FbNewsFields.message,
          ],
        ),
      ),
    );
  }
}
