// To parse this JSON data, do
//
//     final requestResModel = requestResModelFromJson(jsonString);

import 'dart:convert';

import 'package:kyogojo_pay/models/job_order_model.dart';

class JobOrderResModel {
  JobOrderResModel({
    required this.pageSize,
    required this.pageNumber,
    required this.totalRows,
    required this.docs,
  });

  int pageSize;
  int pageNumber;
  int totalRows;
  List<dynamic> docs;

  factory JobOrderResModel.fromRawJson(String str) =>
      JobOrderResModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JobOrderResModel.fromJson(Map<String, dynamic> json) =>
      JobOrderResModel(
        pageSize: json["pageSize"] ?? 0,
        pageNumber: json["pageNumber"] ?? 0,
        totalRows: json["totalRows"] ?? 0,
        docs: List<JobOrderModel>.from(
            json["docs"].map((x) => JobOrderModel.fromJson(x ?? ''))),
      );

  Map<String, dynamic> toJson() => {
        "pageSize": pageSize,
        "pageNumber": pageNumber,
        "totalRows": totalRows,
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
      };
}
