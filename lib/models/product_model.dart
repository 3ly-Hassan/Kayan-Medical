class Product {
  String? name, details, imgUrl, company, category, id;
  double? price, discount, rate;
  int? quantity;
  bool? fav;

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

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    imgUrl = json['imgUrl'];
    price = json['price'];
    discount = json['discount'];
    rate = json['rate'];
    details = json['details'];
    quantity = json['quantity'];
    company = json['company'];
    fav = false;
  }
}
