// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'TestMaterialWidget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("TestMaterialWidget", (WidgetTester tester) async {
    await tester.pumpWidget(
      TestMaterialWidget(child: new Text("myData")),
    );
    expect(
      find.text("myData"),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(TestMaterialWidget, "myData"),
      findsOneWidget,
    );
  });
}
