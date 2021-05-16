// Class for each review card's data
class ReviewCard {
  int id;
  int topicId;
  String question;
  String answer;

  ReviewCard({this.id, this.question, this.answer});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['topic_id'] = topicId;
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }

  // a named constructor, which takes the Map<String, dynamic>
  // as input parameters
  ReviewCard.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.topicId = map['topic_id'];
    this.question = map['question'];
    this.answer = map['answer'];
  }

  // nice way of printing out an object's information
  // calling print(ReviewCardObject) will invoke this method
  @override
  String toString() {
    return '(id: $id, topic_id: $topicId, question: $question, answer: $answer)';
  }
}
