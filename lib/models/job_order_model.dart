// To parse this JSON data, do
//
//     final jobOrderModel = jobOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:kyogojo_pay/models/request_model.dart';

import 'request_models/job_order_request_model.dart';

class JobOrderModel {
  String? id;
  String? referenceId;
  Request? requestBy;
  String? requestType;
  String? formType;
  String? description;
  String? status;
  String? remarks;
  List<Requirement>? requirements;
  Request? requestTo;
  Request? forwardedFrom;
  Request? forwardedTo;
  List<Log>? logs;
  dynamic customerStatusHistory;
  dynamic requestStatus;
  dynamic paymentHistory;
  String? priority;
  Forms? form;
  dynamic userInfo;
  dynamic payment;
  dynamic soa;
  dynamic paymentStatus;
  int? total;
  dynamic schedule;
  dynamic serialNumber;
  dynamic meterFigure;
  dynamic actionType;
  String? instructions;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Mrf?>? mrf;
  List<Requirement>? supportingDocuments;
  String? jobOrderType;

  JobOrderModel({
    this.id,
    this.referenceId,
    this.requestBy,
    this.requestType,
    this.formType,
    this.description,
    this.status,
    this.remarks,
    this.requirements,
    this.requestTo,
    this.forwardedFrom,
    this.forwardedTo,
    this.logs,
    this.customerStatusHistory,
    this.requestStatus,
    this.paymentHistory,
    this.priority,
    this.form,
    this.userInfo,
    this.payment,
    this.soa,
    this.paymentStatus,
    this.total,
    this.schedule,
    this.serialNumber,
    this.meterFigure,
    this.actionType,
    this.instructions,
    this.mrf,
    this.jobOrderType,
    this.supportingDocuments,
    this.createdAt,
    this.updatedAt,
  });

  factory JobOrderModel.fromRawJson(String str) =>
      JobOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JobOrderModel.fromJson(Map<String, dynamic> json) => JobOrderModel(
        id: json["id"] ?? "",
        referenceId: json["referenceId"] ?? "",
        requestBy: Request.fromJson(json["requestBy"]),
        requestType: json["requestType"] ?? "",
        formType: json["formType"] ?? "",
        description: json["description"] ?? "",
        status: json["status"] ?? "",
        remarks: json["remarks"] ?? "",
        mrf: json["mrf"] != null
            ? List<Mrf>.from(json["mrf"].map((x) => Mrf.fromJson(x)))
            : null,
        requirements: List<Requirement>.from(
            json["requirements"]?.map((x) => Requirement.fromJson(x)) ?? []),
        requestTo: json["requestTo"] != null
            ? Request.fromJson(json["requestTo"])
            : null,
        forwardedFrom: json["forwardedFrom"] != null
            ? Request.fromJson(json["forwardedFrom"])
            : null,
        forwardedTo: json["forwardedTo"] != null
            ? Request.fromJson(json["forwardedTo"])
            : null,
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
        supportingDocuments: json["supportingDocuments"] != null
            ? List<Requirement>.from(
                json["supportingDocuments"].map((x) => Requirement.fromJson(x)))
            : [],
        customerStatusHistory: json["customerStatusHistory"],
        requestStatus: json["requestStatus"],
        paymentHistory: json["paymentHistory"],
        priority: json["priority"],
        form: Forms.fromJson(json["form"]),
        userInfo: json["userInfo"],
        payment: json["payment"],
        soa: json["soa"],
        paymentStatus: json["paymentStatus"],
        total: json["total"] ?? "",
        schedule: json["schedule"],
        serialNumber: json["serialNumber"],
        meterFigure: json["meterFigure"],
        actionType: json["actionType"],
        instructions: json["instructions"],
        jobOrderType: json["JobOrderType"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "referenceId": referenceId,
        "requestBy": requestBy?.toJson(),
        "requestType": requestType,
        "formType": formType,
        "description": description,
        "status": status,
        "remarks": remarks,
        'requirements': requirements?.map((x) => x.toJson()).toList(),
        "requestTo": requestTo?.toJson(),
        "forwardedFrom": forwardedFrom?.toJson(),
        "forwardedTo": forwardedTo?.toJson(),
        'logs': logs?.map((x) => x.toJson()).toList(),
        "customerStatusHistory": customerStatusHistory,
        "requestStatus": requestStatus,
        "paymentHistory": paymentHistory,
        "priority": priority,
        "mrf": mrf?.map((x) => x?.toJson() ?? "").toList(),
        "form": form?.toJson(),
        "userInfo": userInfo,
        "payment": payment,
        "soa": soa,
        "paymentStatus": paymentStatus,
        "total": total,
        "schedule": schedule,
        "JobOrderType": jobOrderType ?? "",
        "serialNumber": serialNumber,
        "meterFigure": meterFigure,
        "actionType": actionType,
        "supportingDocuments": supportingDocuments != null
            ? List<dynamic>.from(supportingDocuments!.map((x) => x.toJson()))
            : null,
        "instructions": instructions,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
