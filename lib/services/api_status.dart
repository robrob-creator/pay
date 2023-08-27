import 'package:http/http.dart';

class ApiResponsex {
  int statusCode;
  String success;

  ApiResponsex({required this.statusCode, required this.success});
}

class CustomResponse {
  final Response? response;
  final dynamic error;
  final bool? success;

  CustomResponse({this.response, this.error, this.success});
}

class APIResponse<T> {
  final T? data;
  final dynamic error;
  final bool? success;

  APIResponse({this.data, this.error, this.success});
}
