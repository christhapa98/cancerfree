class AppointmentModel {
  AppointmentModel({
    required this.did,
    required this.reason,
    required this.date,
    required this.uid,
    required this.status,
  });

  String did;
  String reason;
  String date;
  String uid;
  int status;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        did: json["did"],
        reason: json["reason"],
        date: json["date"],
        uid: json["uid"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "did": did,
        "reason": reason,
        "date": date,
        "uid": uid,
        "status": status,
      };
}
