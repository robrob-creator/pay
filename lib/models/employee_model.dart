// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

class EmployeeModel {
  EmployeeModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.email,
    required this.branch,
    required this.city,
    required this.state,
    required this.region,
    required this.title,
    required this.department,
    required this.position,
    required this.designation,
    required this.dateHired,
    required this.sss,
    required this.phic,
    required this.pagibig,
    required this.tin,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    required this.profilePicture,
  });

  String id;
  String userId;
  String firstName;
  String lastName;
  String contactNumber;
  String email;
  String branch;
  String city;
  String state;
  String region;
  String title;
  String department;
  String position;
  String designation;
  DateTime dateHired;
  String sss;
  String phic;
  String pagibig;
  String tin;
  String bankName;
  String accountName;
  String accountNumber;
  String profilePicture;

  factory EmployeeModel.fromRawJson(String str) =>
      EmployeeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        contactNumber: json["contactNumber"],
        email: json["email"],
        branch: json["branch"],
        city: json["city"],
        state: json["state"],
        region: json["region"],
        title: json["title"],
        department: json["department"],
        position: json["position"],
        designation: json["designation"],
        dateHired: DateTime.parse(json["dateHired"]),
        sss: json["sss"],
        phic: json["phic"],
        pagibig: json["pagibig"],
        tin: json["tin"],
        bankName: json["bankName"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "contactNumber": contactNumber,
        "email": email,
        "branch": branch,
        "city": city,
        "state": state,
        "region": region,
        "title": title,
        "department": department,
        "position": position,
        "designation": designation,
        "dateHired": dateHired.toIso8601String(),
        "sss": sss,
        "phic": phic,
        "pagibig": pagibig,
        "tin": tin,
        "bankName": bankName,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "profilePicture": profilePicture,
      };
}
