// To parse this JSON data, do
//
//     final requestResModel = requestResModelFromJson(jsonString);

import 'dart:convert';

import 'package:kyogojo_pay/models/request_model.dart';

class RequestResModel {
  RequestResModel({
    required this.pageSize,
    required this.pageNumber,
    required this.totalRows,
    required this.docs,
    this.statusCode,
  });

  int pageSize;
  int pageNumber;
  int totalRows;
  int? statusCode;
  List<RequestModel> docs;

  factory RequestResModel.fromRawJson(String str) =>
      RequestResModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestResModel.fromJson(Map<String, dynamic> json) =>
      RequestResModel(
        pageSize: json["pageSize"] ?? 0,
        pageNumber: json["pageNumber"] ?? 0,
        totalRows: json["totalRows"] ?? 0,
        statusCode: json["statusCode"] ?? 200,
        docs: List<RequestModel>.from(
            json["docs"].map((x) => RequestModel.fromJson(x ?? ''))),
      );

  Map<String, dynamic> toJson() => {
        "pageSize": pageSize,
        "pageNumber": pageNumber,
        "totalRows": totalRows,
        'statusCode': statusCode,
        "docs": List<RequestModel>.from(docs.map((x) => x.toJson())),
      };
}
