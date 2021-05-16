import 'package:flutter/material.dart';
import 'package:review_cards/models/review-card.dart';
import 'package:review_cards/pages/card-viewer.dart';
import 'package:review_cards/services/rc-database.dart';

class AddCard extends StatefulWidget {
  AddCard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController subjectTextController;
  TextEditingController questionTextController;
  TextEditingController answerTextController;
  final _formKey = GlobalKey<FormState>();
  String subjectText;
  String answerText;
  String questionText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'subject'),
                      controller: subjectTextController,
                      onSaved: (subject) {
                        this.subjectText = subject;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'question'),
                      controller: questionTextController,
                      onSaved: (question) {
                        this.questionText = question;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'answer'),
                      controller: answerTextController,
                      onSaved: (answer) {
                        this.answerText = answer;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          ReviewCard rc = new ReviewCard(
                            question: questionText.toString(),
                            answer: answerText.toString(),
                          );

                          RCDatabase.insertCard(rc);
                        }
                      },
                      child: Text("add"),
                    ),
                    ElevatedButton(
                      onPressed: () async {},
                      child: Text("fetch cards"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await RCDatabase.deleteTable();
                      },
                      child: Text("delete table"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardViewer()));
                      },
                      child: Text("to cards"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
