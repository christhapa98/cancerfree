class UserModel {
  UserModel({
     this.uid,
    required this.name,
    required this.usertype,
    required this.phoneNo,
    required this.email,
    this.admission,
    this.date,
  });

  String? uid;
  String name;
  int usertype;
  String phoneNo;
  String email;
  bool? admission;
  String? date;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        usertype: json["usertype"],
        phoneNo: json["phoneNo"],
        email: json["email"],
        admission: json["admission"],
        date: json["registeredDate"],
      );

  Map<String, dynamic> toAddJson() => {
        "uid": uid,
        "name": name,
        "usertype": usertype,
        "phoneNo": phoneNo,
        "email": email,
        "adminssion": false,
        "date": DateTime.now().toIso8601String(),
      };
}
