class PhLocation {
  String? name;
  String? code;
  String? regionCode;
  String? provinceCode;
  String? cityCode;

  PhLocation(
      {this.name,
      this.code,
      this.regionCode,
      this.provinceCode,
      this.cityCode});

  factory PhLocation.fromJson(Map<String, dynamic> parsedJson) {
    return PhLocation(
        name: parsedJson['name'] ?? "",
        code: parsedJson['code'] ?? "",
        provinceCode: parsedJson['provinceCode'] ?? "",
        cityCode: parsedJson['cityCode'] ?? "",
        regionCode: parsedJson['regionCode'] ?? "");
  }
}
