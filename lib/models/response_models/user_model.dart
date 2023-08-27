// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserResponseModel {
  UserResponseModel({
    this.sub,
    this.emailVerified,
    this.realmAccess,
    this.name,
    this.phoneNumber,
    this.preferredUsername,
    this.givenName,
    this.familyName,
    this.email,
    this.groups,
    this.updatePasswordRequired,
    this.picture,
  });

  String? sub;
  bool? emailVerified;
  RealmAccess? realmAccess;
  String? name;
  String? phoneNumber;
  String? preferredUsername;
  String? givenName;
  String? familyName;
  List<String?>? groups;
  String? email;
  String? picture;
  bool? updatePasswordRequired;

  factory UserResponseModel.fromRawJson(String str) =>
      UserResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
          sub: json["sub"],
          emailVerified: json["email_verified"],
          realmAccess: RealmAccess.fromJson(json["realm_access"] ?? {}),
          name: json["name"],
          phoneNumber: json["phone_number"],
          preferredUsername: json["preferred_username"],
          givenName: json["given_name"],
          familyName: json["family_name"],
          email: json["email"],
          picture: json["picture"],
          groups: json["groups"] != null
              ? List<String>.from(json["groups"].map((x) => x))
              : [],
          updatePasswordRequired: json["update_password_required"]);

  Map<String, dynamic> toJson() => {
        "sub": sub,
        "email_verified": emailVerified,
        "realm_access": realmAccess?.toJson(),
        "name": name,
        "phone_number": phoneNumber,
        "preferred_username": preferredUsername,
        "given_name": givenName,
        "family_name": familyName,
        "email": email,
        "picture": picture,
        "groups": groups?.map((x) => x).toList(),
        "update_password_required": updatePasswordRequired
      };
}

class RealmAccess {
  RealmAccess({
    this.roles,
  });

  List<String>? roles;

  factory RealmAccess.fromRawJson(String str) =>
      RealmAccess.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RealmAccess.fromJson(Map<String, dynamic> json) => RealmAccess(
        roles: json["roles"] != null
            ? List<String>.from(json["roles"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "roles":
            roles != null ? List<dynamic>.from(roles!.map((x) => x)) : null,
      };
}
