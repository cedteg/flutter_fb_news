// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:flutter_fb_news/fb_news_message.dart';
import 'package:flutter_fb_news/flutter_fb_news_config.dart';
import 'package:url_launcher/url_launcher.dart';
import '../TestMaterialWidget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    "FbNewsMessage without text",
    (WidgetTester tester) async {
      Map<String, dynamic> feed = {};
      await tester.pumpWidget(
        TestMaterialWidget(
          child: FbNewsMessage(
            feed: feed,
            config: FbNewsConfig(),
          ),
        ),
      );
      Widget notFoundWidget = Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Linkify(
          onOpen: (link) {
            launch(
              link.url,
            );
          },
          text: "Text",
          style: TextStyle(
            color: FbNewsConfig().textColor,
          ),
          linkStyle: TextStyle(
            color: FbNewsConfig().linkColor,
          ),
        ),
      );

      Widget foundWidget = Container();
      expect(
        find.byWidget(notFoundWidget),
        findsNothing,
      );
      expect(
        find.byWidget(foundWidget),
        findsNothing,
      );
    },
  );
}
