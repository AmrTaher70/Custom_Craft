class GetIconsModel {
  int? id;
  String? pictureUrl;

  GetIconsModel({this.id, this.pictureUrl});

  factory GetIconsModel.fromJson(Map<String, dynamic> json) => GetIconsModel(
        id: json['id'] as int?,
        pictureUrl: json['pictureUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'pictureUrl': pictureUrl,
      };
}
