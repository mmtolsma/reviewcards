// Class for each review card's data
class ReviewCard {
  int id;
  String subject;
  String question;
  String answer;

  ReviewCard({this.id, this.subject, this.question, this.answer});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['subject'] = subject;
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }

  // a constructor, which takes the Map<String, dynamic>
  // as input parameters
  ReviewCard.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        subject = map['subject'],
        question = map['question'],
        answer = map['answer'];

  // nice way of printing out an object's information
  // calling print(ReviewCardObject) will invoke this method
  @override
  String toString() {
    return '(id: $id, subject: $subject, question: $question, answer: $answer)';
  }
}
