class VersionModel {
  String? id; // primary key
  int versionCode;

  VersionModel({
    required this.id,
    required this.versionCode,
  });

  // Convert model to a map for database insertion
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'version_code': versionCode,
    };
  }

  // Create a model from a database map
  factory VersionModel.fromMap(Map<String, dynamic> map) {
    return VersionModel(
      id: map['id'],
      versionCode: map['version_code'],
    );
  }
}
