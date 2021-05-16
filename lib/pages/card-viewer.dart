import 'package:flutter/material.dart';
import 'package:review_cards/models/review-card.dart';
import 'package:review_cards/services/rc-database.dart';

class CardViewer extends StatefulWidget {
  CardViewer({Key key}) : super(key: key);

  @override
  _CardViewerState createState() => _CardViewerState();
}

class _CardViewerState extends State<CardViewer> {
  List<ReviewCard> cards = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Text("${cards[index]}"),
            );
          },
        ),
      ),
    );
  }
}
