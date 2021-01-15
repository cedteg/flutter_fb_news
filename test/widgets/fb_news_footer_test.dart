import 'package:flutter/material.dart';
import 'package:flutter_fb_news/widgets/fb_news_footer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../TestMaterialWidget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("FbNewsFooter with all information", (WidgetTester tester) async {
    Map<String, dynamic> feed = {
      "created_time": "2021-01-15T12:05:39+0000",
      "permalink_url": "https://cedtegappse.de/",
      "likes": {
        "data": [
          {"id": "1"},
          {"id": "2"},
          {"id": "3"},
          {"id": "4"},
          {"id": "5"},
          {"id": "6"},
          {"id": "7"},
          {"id": "8"},
          {"id": "9"},
          {"id": "10"},
          {"id": "11"},
          {"id": "12"},
          {"id": "13"},
          {"id": "14"},
          {"id": "15"},
          {"id": "16"},
          {"id": "17"},
          {"id": "18"},
          {"id": "19"},
          {"id": "20"},
          {"id": "21"},
          {"id": "22"},
          {"id": "23"},
          {"id": "24"},
          {"id": "25"}
        ],
      },
    };
    await tester.pumpWidget(
      TestMaterialWidget(
        child: FbNewsFooter(
          feed: feed,
        ),
      ),
    );
    expect(
      find.widgetWithText(
        ListTile,
        DateTime.parse(feed["created_time"])
            .toLocal()
            .toString()
            .substring(0, 16),
      ),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(Wrap, "25"),
      findsOneWidget,
    );
    expect(
      find.byIcon(Icons.thumb_up),
      findsOneWidget,
    );
  });
  testWidgets("FbNewsFooter without permalink_url",
      (WidgetTester tester) async {
    Map<String, dynamic> feed = {
      "created_time": "2021-01-15T12:05:39+0000",
      "likes": {
        "data": [
          {"id": "1"},
          {"id": "2"},
          {"id": "3"},
          {"id": "4"},
          {"id": "5"},
          {"id": "6"},
          {"id": "7"},
          {"id": "8"},
          {"id": "9"},
          {"id": "10"},
          {"id": "11"},
          {"id": "12"},
          {"id": "13"},
          {"id": "14"},
          {"id": "15"},
          {"id": "16"},
          {"id": "17"},
          {"id": "18"},
          {"id": "19"},
          {"id": "20"},
          {"id": "21"},
          {"id": "22"},
          {"id": "23"},
          {"id": "24"},
          {"id": "25"}
        ],
      },
    };
    await tester.pumpWidget(
      TestMaterialWidget(
        child: FbNewsFooter(
          feed: feed,
        ),
      ),
    );
    expect(
      find.widgetWithText(
        ListTile,
        DateTime.parse(feed["created_time"])
            .toLocal()
            .toString()
            .substring(0, 16),
      ),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(Wrap, "25"),
      findsOneWidget,
    );
    expect(
      find.byIcon(Icons.thumb_up),
      findsOneWidget,
    );
  });
  testWidgets("FbNewsFooter with zero likes", (WidgetTester tester) async {
    Map<String, dynamic> feed = {
      "created_time": "2021-01-15T12:05:39+0000",
      "permalink_url": "https://cedtegappse.de/",
      "likes": {
        "data": [],
      },
    };
    await tester.pumpWidget(
      TestMaterialWidget(
        child: FbNewsFooter(
          feed: feed,
        ),
      ),
    );
    expect(
      find.widgetWithText(
        ListTile,
        DateTime.parse(feed["created_time"])
            .toLocal()
            .toString()
            .substring(0, 16),
      ),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(Wrap, "25"),
      findsNothing,
    );
    expect(
      find.widgetWithText(Wrap, "0"),
      findsOneWidget,
    );
    expect(
      find.byIcon(Icons.thumb_up),
      findsOneWidget,
    );
  });
}
