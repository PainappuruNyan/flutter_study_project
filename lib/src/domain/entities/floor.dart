class Floor{

  Floor(this.id, this.officeId, this.number, this.map);

  Floor.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        officeId = json['officeId'] as int,
        number = json['number'] as int,
        map = json['map'] as String;

  final int id;
  final int officeId;
  final int number;
  final String map;

  Map<String, dynamic> toJson() => <String, dynamic>{
      'id': id,
      'officeId': officeId,
      'number': number,
      'map': map,
    };
}
