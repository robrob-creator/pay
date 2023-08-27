import 'dart:convert';

class FileModel {
  FileModel({this.id, this.links, this.fileName, this.referenceId});

  String? id;
  Links? links;
  String? fileName;
  String? referenceId;

  factory FileModel.fromRawJson(String str) =>
      FileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
      id: json["_id"] ?? "",
      links: Links.fromJson(json["links"] ?? []),
      fileName: json['fileName'] ?? "",
      referenceId: json['referenceId'] ?? "");

  Map<String, dynamic> toJson() => {
        "_id": id,
        "links": links != null ? links?.toJson() : {},
        "fileName": fileName,
        "referenceId": referenceId
      };
}

class Links {
  Links({
    this.original,
    this.thumb,
    this.medium,
  });

  String? original;
  String? thumb;
  String? medium;

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
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
