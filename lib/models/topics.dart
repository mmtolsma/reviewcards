// Class for topics created by the user
class Topics {
  int id;
  String name;
  String description;

  Topics({this.id, this.name, this.description});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    return map;
  }

  Topics.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.description = map['description'];
  }

  @override
  String toString() {
    return '(id: $id, name: $name, description: $description)';
  }
}
