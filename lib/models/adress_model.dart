class AdressModel {
  final String streetName, city, state;
  final String? details;
  final int buildNo, floor;

  AdressModel(
      {required this.streetName,
      required this.city,
      required this.state,
      required this.buildNo,
      required this.floor,
      this.details});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['streetName'] = streetName;
    data['city'] = city;
    data['state'] = state;
    data['buildNo'] = buildNo;
    data['floor'] = floor;
    data['details'] = details;
    return data;
  }
}
