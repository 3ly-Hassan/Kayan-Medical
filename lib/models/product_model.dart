import 'package:flutter/foundation.dart';

class Product {
  final String name, details, imgUrl, company, category;
  final double price, discount, rate;
  final int quantity, id;
  final bool fav;

  Product(
      {required this.id,
      required this.category,
      required this.name,
      required this.details,
      required this.imgUrl,
      required this.price,
      this.discount = 0,
      this.rate = 0,
      this.quantity = 0,
      this.fav = false,
      required this.company});

  Map<String, dynamic> toJson(String id) {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['name'] = name;
    data['imgUrl'] = imgUrl;
    data['price'] = price;
    data['discount'] = discount;
    data['rate'] = rate;
    data['details'] = details;
    data['quantity'] = quantity;
    data['company'] = company;
    return data;
  }
}
