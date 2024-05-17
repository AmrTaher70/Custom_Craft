class GetShapesModel {
  int? id;
  String? pictureUrl;

  GetShapesModel({this.id, this.pictureUrl});

  factory GetShapesModel.fromJson(Map<String, dynamic> json) {
    return GetShapesModel(
      id: json['id'] as int?,
      pictureUrl: json['pictureUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'pictureUrl': pictureUrl,
      };
}
