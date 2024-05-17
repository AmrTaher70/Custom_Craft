class GetItemsModel {
  String? name;
  String? url;
  String? colour;

  GetItemsModel({this.name, this.url, this.colour});

  factory GetItemsModel.fromJson(Map<String, dynamic> json) => GetItemsModel(
        name: json['name'] as String?,
        url: json['url'] as String?,
        colour: json['colour'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'colour': colour,
      };
}
