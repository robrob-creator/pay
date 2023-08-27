class SignupUserReqModel {
  String email;
  String firstName;
  String lastName;
  String phoneNumber;

  SignupUserReqModel({
    this.email = "",
    this.firstName = "",
    this.lastName = "",
    this.phoneNumber = "",
  });

  factory SignupUserReqModel.fromJSON(Map<String, dynamic> json) {
    return SignupUserReqModel(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
      };
}

class SignupUserResModel {
  String? email;
  String? familyName;
  String? givenName;
  String? name;
  bool success;
  String? message;

  SignupUserResModel({
    this.email,
    this.familyName,
    this.givenName,
    this.name,
    this.success = false,
    this.message,
  });

  factory SignupUserResModel.fromJSON(Map<String, dynamic> json) {
    return SignupUserResModel(
      email: json['email'] ?? "",
      familyName: json['family_name'] ?? "",
      givenName: json['given_name'] ?? "",
      name: json['name'] ?? "",
      success: json['success'] ?? true,
      message: json['message'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "family_name": familyName,
        "given_name": givenName,
        "name": name,
        "success": success,
        "message": message,
      };
}
