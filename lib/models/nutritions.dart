class NutritionsModel {
  NutritionsModel({
    required this.type,
    required this.did,
    required this.nutritions,
  });

  String type;
  String did;
  String nutritions;

  factory NutritionsModel.fromJson(Map<String, dynamic> json) =>
      NutritionsModel(
        type: json["type"],
        did: json["did"],
        nutritions: json["nutritions"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "did": did,
        "nutritions": nutritions,
      };
}
