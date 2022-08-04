class TestonomialModel {
  TestonomialModel({
    required this.did,
    required this.messages,
  });

  String did;
  String messages;

  factory TestonomialModel.fromJson(Map<String, dynamic> json) =>
      TestonomialModel(
        did: json["did"],
        messages: json["messages"],
      );

  Map<String, dynamic> toJson() => {
        "did": did,
        "messages": messages,
      };
}
