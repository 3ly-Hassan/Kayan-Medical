import 'package:kayan/models/product_model.dart';

class Cart {
  late Product product;
  late int quantity;

  Cart(this.product, this.quantity);

  Cart.fromJson(Map<String, dynamic> json, Product p) {
    quantity = json['quantity'];
    product = p;
  }
}
