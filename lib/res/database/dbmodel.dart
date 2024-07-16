class DbModel {
  String? id;
  String name;
  String img;
  String releaseDate;
  String listedDate;
  int watchStatus;

  DbModel({
    required this.id,
    required this.name,
    required this.img,
    required this.releaseDate,
    required this.listedDate,
    required this.watchStatus,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
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


  factory DbModel.fromMap(Map<String, dynamic> map) {
    return DbModel(
      id: map['id'],
      name: map['name'],
      img: map['img'],
      releaseDate: map['release_date'],
      listedDate: map['listed_date'],
      watchStatus: map['watch_status'],
    );
  }
}
