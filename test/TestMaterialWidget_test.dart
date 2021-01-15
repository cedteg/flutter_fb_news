import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
