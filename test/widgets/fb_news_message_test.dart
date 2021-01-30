// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:flutter_fb_news/fb_news_message.dart';
import 'package:flutter_fb_news/flutter_fb_news_config.dart';
import '../TestMaterialWidget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("FbNewsMessage without text", (WidgetTester tester) async {
    Map<String, dynamic> feed = {};
    await tester.pumpWidget(
      TestMaterialWidget(
        child: FbNewsMessage(
          feed: feed,
          config: FbNewsConfig(),
        ),
      ),
    );
    expect(
      find.text(feed["message"]),
      findsNothing,
    );
    expect(
      find.widgetWithText(TestMaterialWidget, feed["message"]),
      findsNothing,
    );
  });
}
