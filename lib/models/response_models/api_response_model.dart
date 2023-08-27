import 'dart:convert';

class ApiResponse {
  ApiResponse({
    required this.success,
    required this.statusCode,
    this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String? message;
  dynamic data;

  factory ApiResponse.fromRawJson(String str) =>
      ApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
      success: json["success"],
      statusCode: json["statusCode"],
      data: json["data"],
      message: json["message"]);

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "data": data,
        "message": message
      };
}
