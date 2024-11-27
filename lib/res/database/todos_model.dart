class TodosModel {
  String? id;
  String type;
  String name;
  String img;
  String releaseDate;
  String listedDate;
  int watchStatus;

  TodosModel({
    required this.id,
    required this.type,
    required this.name,
    required this.img,
    required this.releaseDate,
    required this.listedDate,
    required this.watchStatus,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'type': type,
      'name': name,
      'img': img,
      'release_date': releaseDate,
      'listed_date': listedDate,
      'watch_status': watchStatus,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory TodosModel.fromMap(Map<String, dynamic> map) {
    return TodosModel(
      id: map['id'],
      type: map['type'],
      name: map['name'],
      img: map['img'],
      releaseDate: map['release_date'],
      listedDate: map['listed_date'],
      watchStatus: map['watch_status'],
    );
  }
}
