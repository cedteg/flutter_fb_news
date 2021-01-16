// Flutter imports:
import 'package:flutter/material.dart';

class TestMaterialWidget extends StatelessWidget {
  final Widget child;

  const TestMaterialWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: child,
      ),
    );
  }
}
