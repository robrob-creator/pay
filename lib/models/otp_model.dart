class OtpReqModel {
  String phoneNumber;

  OtpReqModel({
    this.phoneNumber = "",
  });

  factory OtpReqModel.fromJSON(Map<String, dynamic> json) {
    return OtpReqModel(
      phoneNumber: json['phonenumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        "phonenumber": phoneNumber,
      };
}

class OtpResModel {
  String? id;
  String? phoneNumber;

  OtpResModel({
    this.id = "",
    this.phoneNumber = "",
  });

  factory OtpResModel.fromJSON(Map<String, dynamic> json) {
    return OtpResModel(
      id: json['_id'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
    );
  }
}

class OtpValidateReqModel {
  String phoneNumber;
  String code;

  OtpValidateReqModel({
    this.phoneNumber = "",
    this.code = "",
  });

  factory OtpValidateReqModel.fromJSON(Map<String, dynamic> json) {
    return OtpValidateReqModel(
      phoneNumber: json['phone_Number'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() => {
        "phone_Number": phoneNumber,
        "code": code,
      };
}

class OtpValidateResModel {
  String? accessToken;
  String? error;

  OtpValidateResModel({
    this.accessToken,
    this.error,
  });

  factory OtpValidateResModel.fromJSON(Map<String, dynamic> json) {
    return OtpValidateResModel(
      accessToken: json['access_token'] ?? "",
      error: json['error_description'] ?? "",
    );
  }
}
