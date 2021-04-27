import 'package:flutter/material.dart';
import 'package:review_cards/services/rc-database.dart';

class SubjectViewer extends StatefulWidget {
  SubjectViewer({Key key}) : super(key: key);

  @override
  _SubjectViewerState createState() => _SubjectViewerState();
}

class _SubjectViewerState extends State<SubjectViewer> {
  List<String> subjects = [];

  getCards() async {
    var _subjects = await RCDatabase.fetchSubjectCards();
    setState(() {
      subjects = _subjects;
    });
  }

  @override
  void initState() {
    getCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          // Add new subject.
          // Update table?
        },
      ),
      appBar: AppBar(
        title: Text("Topics"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to a new page.
                    // pass in subject name to use for the query
                  },
                  child: Container(
                    height: 150,
                    child: Card(
                      color: Colors.grey[300],
                      child: Center(
                        child: Text("${subjects[index]}"),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
