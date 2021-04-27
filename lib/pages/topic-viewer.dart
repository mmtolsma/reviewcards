import 'package:flutter/material.dart';
import 'package:review_cards/services/rc-database.dart';

class TopicViewer extends StatefulWidget {
  TopicViewer({Key key}) : super(key: key);

  @override
  _TopicViewerState createState() => _TopicViewerState();
}

class _TopicViewerState extends State<TopicViewer> {
  List<String> subjects = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  getCards() async {
    var _subjects = await RCDatabase.fetchSubjectCards();
    setState(() {
      subjects = _subjects;
    });
  }

  @override
  void initState() {
    // getCards();
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
        onPressed: () async {
          //showDialog to allow user to add new topic
          addTopicDialog(context);
        },
      ),
      appBar: AppBar(
        title: Text("Topics"),
      ),
      body: Center(
        child: Text(
          "You have no topics yet!\nAdd one by clicking the blue button below!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),

      // Column(
      //   children: [
      //     // Expanded(
      //     //   child: ListView.builder(
      //     //     itemCount: subjects.length,
      //     //     itemBuilder: (BuildContext context, int index) {
      //     //       return GestureDetector(
      //     //         onTap: () {
      //     //           // Navigate to a new page.
      //     //           // pass in subject name to use for the query
      //     //         },
      //     //         child: Container(
      //     //           height: 150,
      //     //           child: Card(
      //     //             color: Colors.grey[300],
      //     //             child: Center(
      //     //               child: Text("${subjects[index]}"),
      //     //             ),
      //     //           ),
      //     //         ),
      //     //       );
      //     //     },
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }

  Future<dynamic> addTopicDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Center(child: Text('Add new topic')),
        content: Form(
          key: _formKey,
          child: TextFormField(
            validator: (topic) {
              return (topic.isEmpty || topic.trim().isEmpty)
                  ? 'Cannot be blank!'
                  : null;
            },
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 50),
                ),
                onPressed: () {
                  // Create new table, add to a list
                  if (_formKey.currentState.validate()) {
                    print("Hey, it's valid!");
                    Navigator.pop(context);
                  }
                },
                child: Text("Add"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 50),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
