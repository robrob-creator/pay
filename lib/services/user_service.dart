import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kyogojo_pay/constants/index.dart';
import "dart:developer" as dev;

import 'package:kyogojo_pay/models/response_models/api_response_model.dart';

class UserService {
  //api call to  create application
  static Future<ApiResponse> login(Map payload) async {
    ApiResponse apiResponse;
    String apiMessage = "";
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'auth0');
      var url = "${AppConstants.apiUrl}/Identity/User/SignIn";

      //encode Map to JSON
      var body = json.encode(payload);

      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: body);

      apiResponse = ApiResponse.fromJson(await json.decode(response.body));
      apiMessage = apiResponse.message ?? "";
      if ([200, 201].contains(apiResponse.statusCode)) {
        return apiResponse;
      } else {
        return apiResponse;
      }
    } catch (e) {
      // return Failure(code: 103, response: {"message": 'Unknown Error'});

      return ApiResponse(
        success: false,
        statusCode: 500,
        message: apiMessage,
      );
    }
  }

  static Future<ApiResponse> updatePassword(Map payload, String token) async {
    try {
      var url = "${AppConstants.apiUrl}/Identity/User/UpdatePassword";

      //encode Map to JSON
      var body = json.encode(payload);

      var response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: body);
      if ([200, 201, 204].contains(response.statusCode)) {
        var apiResponse =
            ApiResponse.fromJson(await json.decode(response.body));
        dev.inspect(apiResponse);
        return apiResponse;
      }
      return ApiResponse(success: false, statusCode: 500);
    } catch (e) {
      // return Failure(code: 103, response: {"message": 'Unknown Error'});
      dev.inspect(e);
      return ApiResponse(success: false, statusCode: 500);
    }
  }

  static Future<ApiResponse> forgotPassword(Map<String, dynamic>? query) async {
    try {
      var url = "${AppConstants.apiUrl}/Identity/User/ForgotPassword";

      //encode Map to JSON

      var response = await http.post(
        Uri.parse(url).replace(queryParameters: query),
        headers: {
          "Content-Type": "application/json",
        },
      );

      var apiResponse = ApiResponse.fromJson(await json.decode(response.body));
      dev.inspect(apiResponse);
      return apiResponse;
    } catch (e) {
      // return Failure(code: 103, response: {"message": 'Unknown Error'});
      dev.inspect(e);
      return ApiResponse(success: false, statusCode: 500);
    }
  }

  static Future<ApiResponse> getProfile() async {
    ApiResponse apiResponse;
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth0');
    var url = "${AppConstants.apiUrl}/Identity/User/Profile";

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    apiResponse = ApiResponse.fromJson(await json.decode(response.body));

    return apiResponse;
  }
}
