import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kyogojo_pay/models/signup_model.dart';

class SignupService {
  static Future<SignupUserResModel?> createAccount(
      SignupUserReqModel data) async {
    SignupUserResModel? result;
    String baseUrl = dotenv.get("BASE_URL");
    try {
      var url = Uri.parse("$baseUrl/USER");
      var body = json.encode(data);
      var resp = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      var out = json.decode(resp.body);
      result = SignupUserResModel.fromJSON(out);
    } catch (e) {
      return result;
    }
    return result;
  }
}
