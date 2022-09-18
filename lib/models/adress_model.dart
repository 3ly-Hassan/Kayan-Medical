import 'package:flutter/material.dart';

class AdressModel {
  late final String streetName, city, state;
  late final String? details;
  late final int buildNo, floor;
  late final String id;

  AdressModel(
      {required this.id,
      required this.streetName,
      required this.city,
      required this.state,
      required this.buildNo,
      required this.floor,
      this.details});
  Map<String, dynamic> toJson(String id) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['streetName'] = streetName;
    data['city'] = city;
    data['state'] = state;
    data['buildNo'] = buildNo;
    data['floor'] = floor;
    data['details'] = details;
    return data;
  }

  AdressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    streetName = json['streetName'];
    city = json['city'];
    state = json['state'];
    buildNo = json['buildNo'];
    floor = json['floor'];
    details = json['details'];
  }
}
