class Employee{

  Employee(this.userId, this.id, this.title, this.body);

  Employee.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int,
        id = json['id'] as int,
        title = json['title'] as String,
        body = json['title'] as String;

  final int userId;
  final int id;
  final String title;
  final String body;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'userId':userId,
    'id':id,
    'title':title,
    'body':body,
  };
}
