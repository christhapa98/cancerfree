class BiilModel {
  BiilModel({
    required this.image,
    required this.uid,
    required this.description,
    required this.title,
  });

  String image;
  String uid;
  String description;
  String title;

  factory BiilModel.fromJson(Map<String, dynamic> json) => BiilModel(
        image: json["image"],
        uid: json["uid"],
        description: json["description"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "uid": uid,
        "description": description,
        "title": title,
      };
}
