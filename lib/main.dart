import 'package:flutter/material.dart';
import 'package:review_cards/pages/add-card.dart';
import 'package:review_cards/pages/card-viewer.dart';
import 'package:review_cards/pages/topic-viewer.dart';
import 'package:review_cards/services/rc-database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RCDatabase.openDB();

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
