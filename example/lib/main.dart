// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_fb_news/flutter_fb_news.dart';
import 'package:flutter_fb_news/flutter_fb_news_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_fb_news example',
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
        child: Scrollbar(
          child: SingleChildScrollView(
            child: FbNews(
              accesToken:
                  "EAAEv8mmmPuQBAOrgI8sXDn0sZC7FdMZBzZBHCoETsnAs5aW59tBVg9YNzTiZAcroymSoauspyJ0QFl21z61fKaCERpMNu1itCvJPPyuZAUhX7GJzQsiyE69QPvxZCFnSBX0gnJGojHZCU8ZAviY2yAdzCVJfAfGUkT40aDbwRlK1uxjBZAiJuQSBhB6f4Wf9uHccZD",
              pageId: "100877422026798",
              limit: 25,
              config: FbNewsConfig(
                borderColor: Colors.black,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                showBorder: false,
                subtitle: "von Facebook",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
