import 'package:flutter/material.dart';
import 'package:review_cards/pages/topic-viewer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Review Cards',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TopicViewer(),
    );
  }
}
