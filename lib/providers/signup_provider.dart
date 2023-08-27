import 'package:flutter/material.dart';

import 'dart:developer' as dev;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kyogojo_pay/models/otp_model.dart';
import 'package:kyogojo_pay/models/response_models/api_response_model.dart';
import 'package:kyogojo_pay/models/response_models/user_model.dart';
import 'package:kyogojo_pay/models/signup_model.dart';
import 'package:kyogojo_pay/services/user_service.dart';

class SignupDataProvider with ChangeNotifier {
  SignupUserReqModel? user;
  UserResponseModel profile = UserResponseModel();
  // Credentials? credentials;
  String? accessToken;
  String? accessTokenTemp;
  String? prevAccessTokenTemp;
  bool loading = false;
  String errorMessage = "";
  OtpResModel? otp;
  OtpValidateResModel? otpResp;
  bool bio = false;
  bool firstTimeUser = true;
  final String stateKey = 'auth0';
  final storage = const FlutterSecureStorage();
  bool sessionExpireModal = false;

  Future init(BuildContext context) async {
    final data = await storage.read(key: stateKey);
    final xbio = await storage.read(key: "biometrix");
    accessToken = null;
    accessTokenTemp = null;
    if (data != null) {
      accessToken = data;
    }

    bio = xbio == "true" ? true : false;
    notifyListeners();
  }

  void isFirstimeUser() async {
    String? value = await storage.read(key: 'newUser');
    bool isFirsttime = (value == null ? true : false);
    firstTimeUser = isFirsttime;
    notifyListeners();
  }

  void setBio(bool val) async {
    bio = val;
    await storage.write(key: "biometrix", value: bio ? "true" : "false");
    notifyListeners();
  }

  void setLoading(bool val) async {
    loading = val;
    notifyListeners();
  }

  void saveState() async {
    try {
      await storage.write(
          key: stateKey, value: accessTokenTemp ?? prevAccessTokenTemp);
      await storage.write(key: "biometrix", value: bio ? "true" : "false");
      accessTokenTemp = null;
    } catch (e) {
      dev.log(e.toString());
    }
  }

  notify() async {
    notifyListeners();
  }

  getProfile() async {
    loading = true;
    errorMessage = "";
    notifyListeners();

    try {
      if (accessToken != null) {
        var res = await UserService.getProfile();
        profile = UserResponseModel.fromJson(res.data);
      }
    } catch (e) {
      errorMessage = e.toString().replaceAll("invalid_grant: ", "");
    }

    loading = false;
    notifyListeners();
  }

  setAccess() {
    accessToken = accessTokenTemp;
    notifyListeners();
  }

  setFirstAccess() {
    accessToken = prevAccessTokenTemp;
    notifyListeners();
  }

  setPrevAccess(String data) {
    prevAccessTokenTemp = data;
    notifyListeners();
  }

  setDetails(SignupUserReqModel data) {
    user = data;
    errorMessage = "";
    notifyListeners();
  }

  Future<ApiResponse> login(Map payload) async {
    loading = true;
    errorMessage = "";
    notifyListeners();

    try {
      var data = await UserService.login(payload);
      // dev.inspect(data);
      if ([200, 201].contains(data.statusCode)) {
        accessToken = data.data["access_token"];
        storage.write(key: stateKey, value: data.data["access_token"]);

        loading = false;
        return data;
      }
      return data;
    } catch (e) {
      errorMessage = e.toString().replaceAll("invalid_grant: ", "");
      loading = false;
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: errorMessage,
      );
    }
  }

  updatePassword(Map payload, String token) async {
    loading = true;
    errorMessage = "";
    notifyListeners();

    try {
      var data = await UserService.updatePassword(payload, token);
      // dev.inspect(data);
      if ([200, 201].contains(data.statusCode)) {
        loading = false;

        return data;
      }
      return data;
    } catch (e) {
      errorMessage = e.toString().replaceAll("invalid_grant: ", "");
      dev.inspect(e);
      loading = false;
      return false;
    }
  }

  Future<ApiResponse> forgotPassword(Map<String, dynamic>? payload) async {
    loading = true;
    errorMessage = "";
    notifyListeners();

    try {
      var data = await UserService.forgotPassword(payload);
      // dev.inspect(data);
      if ([200, 201].contains(data.statusCode)) {
        loading = false;
        return data;
      }
      loading = false;
      return data;
    } catch (e) {
      errorMessage = e.toString().replaceAll("invalid_grant: ", "");
      dev.inspect(e);
      loading = false;
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: errorMessage,
      );
    }
  }

  // requestOtp() async {
  //   loading = true;
  //   errorMessage = "";
  //   notifyListeners();

  //   try {
  //     var data = OtpReqModel(phoneNumber: user!.phoneNumber);
  //     var result = await OtpService.reqOtp(data);
  //     otp = result;
  //   } catch (e) {
  //     errorMessage = e.toString().replaceAll("invalid_grant: ", "");
  //     dev.log(e.toString());
  //   }

  //   loading = false;
  //   notifyListeners();
  // }

  // Future<OtpValidateResModel?> validateOtp(String code) async {
  //   OtpValidateResModel result;
  //   loading = true;
  //   errorMessage = "";
  //   notifyListeners();

  //   try {
  //     var data =
  //         OtpValidateReqModel(phoneNumber: user!.phoneNumber, code: code);
  //     result = await OtpService.validateOtp(data);
  //     accessTokenTemp = result.accessToken!;
  //     saveState();
  //   } catch (e) {
  //     errorMessage = e.toString().replaceAll("invalid_grant: ", "");
  //     dev.log(e.toString());
  //     return null;
  //   }

  //   loading = false;
  //   notifyListeners();
  //   otpResp = result;
  //   return result;
  // }

  // // NOTE: Depercated replaced with Passwordless
  // resetPassword(Auth0 auth0) async {
  //   loading = true;
  //   errorMessage = "";
  //   notifyListeners();

  //   try {
  //     await auth0.api
  //         .resetPassword(email: user!.email, connection: "kyogojo-users");
  //   } catch (e) {
  //     errorMessage = e.toString().replaceAll("invalid_grant: ", "");
  //     dev.log(e.toString());
  //     loading = false;
  //   }

  //   loading = false;
  //   notifyListeners();
  // }

  logout() async {
    loading = true;
    errorMessage = "";
    // credentials = null;
    accessTokenTemp = null;
    accessToken = null;
    storage.delete(key: stateKey);
    loading = false;
    notifyListeners();
  }

  // Future<SignupUserResModel?> createAccount(Auth0 auth0) async {
  //   loading = true;
  //   errorMessage = "";
  //   SignupUserResModel? result;
  //   notifyListeners();

  //   try {
  //     result = await SignupService.createAccount(user!);
  //   } catch (e) {
  //     dev.log(e.toString());
  //     errorMessage = e.toString().replaceAll("invalid_grant: ", "");
  //     notifyListeners();
  //     loading = false;
  //   }

  //   loading = false;
  //   notifyListeners();
  //   return result;
  // }
}
