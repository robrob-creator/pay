import 'dart:convert';

RequestModel requestModelFromJson(String str) =>
    RequestModel.fromJson(json.decode(str));
String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
  RequestModel({
    required this.requestType,
    required this.formType,
    required this.form,
    required this.requestBy,
    this.status,
    this.logs,
    this.id,
    this.soa,
    this.total,
    this.meterNumber,
    this.schedule,
    this.customerStatusHistory,
    this.requestStatus,
    this.createdAt,
    this.forwardedTo,
    this.updatedAt,
    this.paymentStatus,
    this.requirements,
  });

  String? id;
  String requestType;
  String formType;
  String? status;
  String? meterNumber;
  Forms form;
  List<Requirement>? requirements;
  RequestBy requestBy;
  List<Log>? logs;
  List<Soa>? soa;
  List<RequestStatus>? requestStatus;
  int? total;
  String? schedule;
  List<CustomerStatusHistory>? customerStatusHistory;
  DateTime? createdAt;
  String? paymentStatus;
  DateTime? updatedAt;
  ForwardedTo? forwardedTo;

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json["id"] ?? '',
        paymentStatus: json["paymentStatus"] ?? '',
        requestType: json["requestType"] ?? '',
        schedule: json["schedule"] ?? DateTime.now().toIso8601String(),
        formType: json["formType"] ?? '',
        status: json["status"] ?? '',
        meterNumber: json["meterNumber"] ?? '',
        form: Forms.fromJson(json["form"]),
        requestBy: RequestBy.fromJson(json["requestBy"]),
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
        requirements: List<Requirement>.from(json["requirements"] != null
            ? json["requirements"].map((x) => Requirement.fromJson(x ?? ''))
            : {}),
        soa: List<Soa>.from(json["soa"].map((x) => Soa.fromJson(x))),
        total: json["total"] ?? 0,
        customerStatusHistory: List<CustomerStatusHistory>.from(
            json["customerStatusHistory"]
                .map((x) => CustomerStatusHistory.fromJson(x))),
        requestStatus: List<RequestStatus>.from(
            json["requestStatus"].map((x) => RequestStatus.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        forwardedTo: ForwardedTo.fromJson(json["forwardedTo"] ?? {}),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "requestType": requestType,
        "paymentStatus": paymentStatus,
        "formType": formType,
        "status": status,
        "form": form.toJson(),
        "requestBy": requestBy.toJson(),
        "logs": logs != null
            ? List<dynamic>.from(logs!.map((x) => x.toJson()))
            : [],
        "requirements":
            List<dynamic>.from(requirements?.map((x) => x.toJson()) ?? []),
        "soa": List<dynamic>.from(soa?.map((x) => x.toJson()) ?? []),
        "total": total ?? 0,
        "schedule": schedule ?? DateTime.now().toIso8601String(),
        "meterNumber": meterNumber ?? "",
        // ignore: prefer_null_aware_operators
        "requestStatus": requestStatus != null
            ? requestStatus?.map((x) => x.toJson())
            : null,
        "customerStatusHistory": List<dynamic>.from(
            customerStatusHistory?.map((x) => x.toJson()) ?? []),
        "forwardedTo": forwardedTo?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Forms {
  Forms(
      {required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.suffix,
      this.phoneNumber,
      this.birthdate,
      this.age,
      this.addressList,
      this.monthlyIncome,
      this.installationAddress,
      this.connectionType});
  String firstName;
  String lastName;
  String middleName;
  String? suffix;
  String? phoneNumber;

  String? birthdate;
  String? age;
  String? monthlyIncome;
  String? connectionType;
  Address? installationAddress;
  List<Address>? addressList;
  factory Forms.fromJson(Map<String, dynamic> json) => Forms(
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        middleName: json["middleName"] ?? '',
        suffix: json["suffix"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        birthdate: json["birthdate"] ?? '',
        age: json["age"] ?? '',
        monthlyIncome: json["monthlyIncome"] ?? '',
        connectionType: json["connectionType"] ?? '',
        installationAddress:
            Address.fromJson(json["installationAddress"] ?? {}),
        addressList: List<Address>.from(
            json["addressList"].map((x) => Address.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "suffix": suffix,
        "phoneNumber": phoneNumber,
        "birthdate": birthdate,
        "age": age,
        "monthlyIncome": monthlyIncome,
        "connectionType": connectionType,
        "installationAddress": installationAddress?.toJson(),
        "addressList": addressList != null
            ? List<dynamic>.from(addressList!.map((x) => x.toJson()))
            : [],
      };
}

class RequestBy {
  RequestBy({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.mobileNumber,
    required this.type,
  });
  String id;
  String email;
  String firstName;
  String lastName;
  String middleName;
  String mobileNumber;
  String type;
  factory RequestBy.fromJson(Map<String, dynamic> json) => RequestBy(
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"],
        middleName: json["middleName"] ?? '',
        mobileNumber: json["mobileNumber"] ?? '',
        type: json["type"] ?? '',
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "mobileNumber": mobileNumber,
        "type": type,
      };
}

class Log {
  Log({
    required this.userId,
    required this.action,
    required this.status,
    this.remarks,
    required this.date,
  });
  String userId;
  String action;
  String status;
  dynamic remarks;
  DateTime date;
  factory Log.fromJson(Map<String, dynamic> json) => Log(
        userId: json["userId"],
        action: json["action"],
        status: json["status"],
        remarks: json["remarks"],
        date: DateTime.parse(json["date"]),
      );
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "action": action,
        "status": status,
        "remarks": remarks,
        "date": date.toIso8601String(),
      };
}

class Address {
  Address(
      {this.longitude,
      this.latitude,
      this.description,
      this.province,
      this.city,
      this.region,
      this.barangay,
      this.street,
      this.landmark});
  double? longitude;
  double? latitude;
  String? description;
  String? region;
  String? province;
  String? city;
  String? barangay;
  String? street;
  String? landmark;
  factory Address.fromJson(Map<String, dynamic> json) => Address(
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        description: json["description"],
        province: json["province"],
        city: json["city"],
        region: json["region"] ?? "",
        barangay: json["barangay"],
        street: json["street"],
        landmark: json["landmark"] ?? "",
      );
  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
        "description": description,
        "region": region ?? "",
        "province": province,
        "city": city,
        "barangay": barangay,
        "street": street,
        "landmark": landmark ?? ""
      };
}

class Requirement {
  Requirement({
    this.name,
    this.referenceId,
    this.description,
    this.attachments,
    this.status,
    this.filename,
    // this.type,
    // this.status,
    this.remarks,
  });

  String? name;
  String? referenceId;
  String? description;
  String? status;
  String? filename;
  Attachments? attachments;
  // String? type;
//  String? status;
  String? remarks;

  factory Requirement.fromRawJson(String str) =>
      Requirement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
        name: json["name"] ?? "",
        referenceId: json["referenceId"] ?? "",
        description: json["description"] ?? "",
        status: json["status"] ?? "",
        filename: json["filename"] ?? "",
        attachments: Attachments.fromJson(json["attachments"] ?? {}),
        //  type: json["type"],
        // status: json["status"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "referenceId": referenceId,
        "description": description,
        "status": status,
        "filename": filename,
        "attachments": attachments?.toJson(),
        // "type": type,
        // "status": status,
        "remarks": remarks,
      };
}

class Soa {
  Soa({
    this.particular,
    this.amount,
  });

  String? particular;
  int? amount;

  factory Soa.fromRawJson(String str) => Soa.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Soa.fromJson(Map<String, dynamic> json) => Soa(
        particular: json["particular"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "particular": particular,
        "amount": amount,
      };
}

class CustomerStatusHistory {
  CustomerStatusHistory({
    this.status,
    this.checked,
    this.date,
  });

  String? status;
  bool? checked;
  DateTime? date;

  factory CustomerStatusHistory.fromRawJson(String str) =>
      CustomerStatusHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerStatusHistory.fromJson(Map<String, dynamic> json) =>
      CustomerStatusHistory(
        status: json["status"],
        checked: json["checked"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "checked": checked,
        "date": date?.toIso8601String(),
      };
}

class Attachments {
  Attachments({
    this.original,
    this.thumb,
    this.medium,
  });

  String? original;
  String? thumb;
  String? medium;

  factory Attachments.fromRawJson(String str) =>
      Attachments.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attachments.fromJson(Map<String, dynamic> json) => Attachments(
        original: json["original"] ?? "",
        thumb: json["thumb"] ?? "",
        medium: json["medium"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "thumb": thumb,
        "medium": medium,
      };
}

class ForwardedTo {
  ForwardedTo({
    this.id,
    this.email,
    this.lastName,
    this.firstName,
    this.middleName,
    this.suffix,
    this.contactNumber,
    this.type,
    this.designation,
    this.profilePicture,
  });

  String? id;
  String? email;
  String? lastName;
  String? firstName;
  String? middleName;
  String? suffix;
  String? contactNumber;
  String? type;
  String? designation;
  String? profilePicture;

  factory ForwardedTo.fromRawJson(String str) =>
      ForwardedTo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForwardedTo.fromJson(Map<String, dynamic> json) => ForwardedTo(
        id: json["id"],
        email: json["email"],
        lastName: json["lastName"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        suffix: json["suffix"],
        contactNumber: json["contactNumber"],
        type: json["type"],
        designation: json["designation"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "lastName": lastName,
        "firstName": firstName,
        "middleName": middleName,
        "suffix": suffix,
        "contactNumber": contactNumber,
        "type": type,
        "designation": designation,
        "profilePicture": profilePicture,
      };
}

class RequestStatus {
  String? referenceId;
  String? type;
  String? title;
  String? status;
  DateTime? date;

  RequestStatus({
    this.referenceId,
    this.type,
    this.title,
    this.status,
    this.date,
  });

  factory RequestStatus.fromRawJson(String str) =>
      RequestStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestStatus.fromJson(Map<String, dynamic> json) => RequestStatus(
        referenceId: json["referenceId"],
        type: json["type"],
        title: json["title"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "type": type,
        "title": title,
        "status": status,
        "date": date?.toIso8601String(),
      };
}
