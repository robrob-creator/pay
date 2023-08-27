// To parse this JSON data, do
//
//     final jobOrderRequestModel = jobOrderRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:kyogojo_pay/models/request_model.dart';

class JobOrderRequestModel {
  String referenceId;
  String? userId;
  String description;
  String remarks;
  String priority;
  String instructions;
  String? jobOrderType;
  String requestType;
  String formType;
  Forms? form;
  String? serialNumber;
  String? meterFigure;
  Request? requestBy;
  Request? requestTo;
  List<dynamic>? logs;
  List<Requirement>? requirements;
  List<Mrf>? mrf;
  List<Requirement>? supportingDocuments;

  JobOrderRequestModel(
      {required this.referenceId,
      required this.description,
      required this.remarks,
      required this.priority,
      required this.instructions,
      required this.requestType,
      required this.formType,
      this.userId,
      this.form,
      this.jobOrderType,
      this.requestBy,
      this.requestTo,
      this.meterFigure,
      this.serialNumber,
      this.logs,
      this.supportingDocuments,
      this.requirements,
      this.mrf});

  factory JobOrderRequestModel.fromRawJson(String str) =>
      JobOrderRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JobOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      JobOrderRequestModel(
        referenceId: json["referenceId"],
        description: json["description"],
        remarks: json["remarks"],
        userId: json["userId"],
        priority: json["priority"],
        instructions: json["instructions"],
        requestType: json["requestType"],
        formType: json["formType"],
        form: Forms.fromJson(json["form"]),
        mrf: List<Mrf>.from(json["mrf"].map((x) => Mrf.fromJson(x))),
        supportingDocuments: json["supportingDocuments"] != null
            ? List<Requirement>.from(
                json["supportingDocuments"].map((x) => Requirement.fromJson(x)))
            : [],
        requestBy: Request.fromJson(json["requestBy"]),
        requestTo: Request.fromJson(json["requestTo"]),
        jobOrderType: json["JobOrderType"] ?? "",
        serialNumber: json["serialNumber"] ?? "",
        meterFigure: json["meterFigure"] ?? "",
        logs: List<dynamic>.from(json["logs"].map((x) => x)),
        requirements: List<Requirement>.from(
            json["requirements"].map((x) => Requirement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "description": description,
        "remarks": remarks,
        "userId": userId,
        "priority": priority,
        "instructions": instructions,
        "requestType": requestType,
        "formType": formType,
        "mrf": mrf?.map((x) => x.toJson()).toList(),
        "form": form?.toJson(),
        "requestBy": requestBy?.toJson(),
        "JobOrderType": jobOrderType,
        "requestTo": requestTo?.toJson(),
        "serialNumber": serialNumber,
        "meterFigure": meterFigure,
        "supportingDocuments": supportingDocuments != null
            ? List<dynamic>.from(supportingDocuments!.map((x) => x.toJson()))
            : null,
        "logs": logs?.map((x) => x).toList(),
        'requirements': requirements?.map((x) => x.toJson()).toList(),
      };
}

class Request {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? middleName;
  String? mobileNumber;
  String? designation;
  String? type;
  String? profilePicture;

  Request({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.middleName,
    this.mobileNumber,
    this.designation,
    this.profilePicture,
    this.type,
  });

  factory Request.fromRawJson(String str) => Request.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        mobileNumber: json["mobileNumber"],
        designation: json["designation"],
        profilePicture: json["profilePicture"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "mobileNumber": mobileNumber,
        "designation": designation,
        "profilePicture": profilePicture,
        "type": type,
      };
}

class Mrf {
  String? itemDescription;
  int? quantity;
  String? unit;

  Mrf({
    this.itemDescription,
    this.quantity,
    this.unit,
  });

  factory Mrf.fromRawJson(String str) => Mrf.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Mrf.fromJson(Map<String, dynamic> json) => Mrf(
        itemDescription: json["description"] ?? "",
        quantity: json["quantity"] ?? 0,
        unit: json["unit"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "description": itemDescription ?? "",
        "quantity": quantity ?? 0,
        "unit": unit ?? "",
      };
}
