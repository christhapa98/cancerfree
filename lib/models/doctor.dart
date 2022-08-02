class DoctorModel {
  DoctorModel({
    this.id,
    required this.name,
    required this.phoneNo,
    required this.shift,
  });

  String? id;
  String name;
  String phoneNo;
  int shift;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json["id"],
        name: json["name"],
        phoneNo: json["phoneNo"],
        shift: json["shift"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNo": phoneNo,
        "shift": shift,
      };
}
