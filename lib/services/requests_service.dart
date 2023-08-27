import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kyogojo_pay/constants/index.dart';

import 'dart:developer' as dev;

import 'package:kyogojo_pay/models/request_model.dart';
import 'package:kyogojo_pay/models/request_response_model.dart';
import 'package:kyogojo_pay/models/response_models/api_response_model.dart';

class RequestsService {
  //api call to  create application
  static Future<http.Response> createRequest(RequestModel payload) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth0');
    var url = "${AppConstants.apiUrl}/Request";

    //encode Map to JSON
    var body = json.encode(payload);

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConstants.apiUrl}"
        },
        body: body);
    return response;
  }

  //api call to edit application
  static Future<http.Response> editRequest(
      RequestModel payload, String id) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth0');
    var url = "${AppConstants.apiUrl}/Request/$id";
    //encode Map to JSON

    var body = json.encode(payload);
    var response = await http.patch(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConstants.apiUrl}"
        },
        body: body);
    dev.inspect(response.body);
    return response;
  }

  static Future<ApiResponse> paymentRequest(
      Map<String, dynamic> payload, String id) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth0');
    var url = "${AppConstants.apiUrl}/Request/$id/pay";
    //encode Map to JSON

    try {
      var body = json.encode(payload);
      var response = await http.patch(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: body);
      if ([200, 201, 204].contains(response.statusCode)) {
        return ApiResponse(success: true, statusCode: 200);
      }

      return ApiResponse(success: false, statusCode: response.statusCode);
    } catch (err) {
      return ApiResponse(success: false, statusCode: 500);
    }
  }

  static Future<http.Response> editSOA(List<Soa> payload, String id) async {
    const storage = FlutterSecureStorage();
    var formatedPayload = {"soa": payload};
    var token = await storage.read(key: 'auth0');
    var url = "${AppConstants.apiUrl}/Soa/$id/edit";
    //encode Map to JSON

    var body = json.encode(formatedPayload);
    var response = await http.patch(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConstants.apiUrl}"
        },
        body: body);
    dev.inspect(response.body);
    return response;
  }

  //api call to fetch user application
  static Future<List<RequestModel>> getRequestByUser(id) async {
    List<RequestModel> requestModels;
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth0');
    var url = "${AppConstants.apiUrl}/Request/user/$id";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConstants.apiUrl}"
        },
      );

      requestModels = (await json.decode(response.body) as List)
          .map((i) => RequestModel.fromJson(i))
          .toList();
      return requestModels;
    } catch (err) {
      throw Exception('Failed to load requests');
    }
  }

  //api call to fetch all applications
  static Future<RequestResModel> getRequest(Map<String, dynamic>? query) async {
    RequestResModel requestModels;
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth0');
    var url = "${AppConstants.apiUrl}/Request";
    dev.inspect(query);
    try {
      var response = await http.get(
        Uri.parse(url).replace(queryParameters: query),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if ([200, 201, 204].contains(response.statusCode)) {
        var out = json.decode(response.body);
        requestModels = RequestResModel.fromJson(out);

        return requestModels;
      }
      return RequestResModel(
          pageSize: 0, pageNumber: 0, totalRows: 0, docs: [], statusCode: 400);
    } catch (err) {
      return RequestResModel(
          pageSize: 0, pageNumber: 0, totalRows: 0, docs: [], statusCode: 400);
    }
  }

  //api call to fetch all application by id
  static Future<RequestModel> getRequestByID(id) async {
    RequestModel requestModel;
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth0');

    try {
      var url = "${AppConstants.apiUrl}/Request/$id";
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConstants.apiUrl}"
        },
      );
      requestModel = RequestModel.fromJson(await json.decode(response.body));

      return requestModel;
    } catch (err) {
      throw Exception('Failed to load request');
    }
  }

  // static Future<ApiResponse> uploadFile(File file, String id) async {
  //   var result = ApiResponse(success: false, statusCode: 500);
  //   var url = "${AppConstants.apiUrl}/File/$id/Upload";
  //   const storage = FlutterSecureStorage();
  //   var token = await storage.read(key: 'auth0');
  //   try {
  //     var request = http.MultipartRequest("POST", Uri.parse(url));
  //     request.headers.addAll(
  //         {'Authorization': 'Bearer ${AppConstants.apiUrl}'}); // Add Authorization header

  //     var pic = await http.MultipartFile.fromPath("file", file.path,
  //         contentType: MediaType(lookupMimeType(file.path)?.split('/')[0] ?? "",
  //             lookupMimeType(file.path)?.split('/')[1] ?? ""));
  //     request.files.add(pic);
  //     var response = await request.send();
  //     var resp = await http.Response.fromStream(response);
  //     var out = json.decode(resp.body);
  //     result = ApiResponse.fromJson(out);
  //     return result;
  //   } catch (err) {
  //     return ApiResponse(success: false, statusCode: 500, data: {});
  //   }
  // }

  // //api call to approve application
  // static Future<http.Response> approveRequest(Map payload, String id) async {
  //   const storage = FlutterSecureStorage();
  //   var token = await storage.read(key: 'auth0');
  //   var url = "${AppConstants.apiUrl}/Request/$id/Approve";
  //   //encode Map to JSON
  //   dev.inspect(payload);
  //   var body = json.encode(payload);
  //   var response = await http.patch(Uri.parse(url),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer ${AppConstants.apiUrl}"
  //       },
  //       body: body);
  //   dev.inspect(response);
  //   return response;
  // }

  // //api call to approve application
  // static Future<APIResponse> approveSOA(String id) async {
  //   const storage = FlutterSecureStorage();
  //   var token = await storage.read(key: 'auth0');
  //   var url = "${AppConstants.apiUrl}/Soa/$id/Approve";

  //   try {
  //     var response = await http.patch(Uri.parse(url), headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer ${AppConstants.apiUrl}"
  //     });

  //     if ([200, 201, 204].contains(response.statusCode)) {
  //       return APIResponse(success: true);
  //     } else {
  //       return APIResponse(success: false, error: response.body);
  //     }
  //   } catch (err) {
  //     return APIResponse(success: false, error: err.toString());
  //   }
  // }

  //api call to disapprove application
  static Future<http.Response> disapproveRequest(Map payload, String id) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'auth0');
    var url = "${AppConstants.apiUrl}/Request/$id/Disapprove";
    //encode Map to JSON

    var body = json.encode(payload);
    var response = await http.patch(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppConstants.apiUrl}"
        },
        body: body);
    dev.inspect(response);
    return response;
  }
}
