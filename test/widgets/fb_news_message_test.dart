// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:flutter_fb_news/widgets/fb_news_message.dart';
import '../TestMaterialWidget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("FbNewsMessage with text", (WidgetTester tester) async {
    Map<String, dynamic> feed = {
      "message": "random text",
    };
    await tester.pumpWidget(
      TestMaterialWidget(
        child: FbNewsMessage(
          feed: feed,
        ),
      ),
    );
    expect(
      find.text(feed["message"]),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(TestMaterialWidget, feed["message"]),
      findsOneWidget,
    );
  });
  testWidgets("FbNewsMessage without text", (WidgetTester tester) async {
    Map<String, dynamic> feed = {};
    await tester.pumpWidget(
      TestMaterialWidget(
        child: FbNewsMessage(
          feed: feed,
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
