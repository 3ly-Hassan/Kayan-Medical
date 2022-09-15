import 'package:kayan/models/adress_model.dart';
import 'package:kayan/models/cart_model.dart';
import 'package:kayan/shared/shared.dart';

class OrderModel {
  final double totalAmount;
  final String orderDate;
  final String orderClock;
  final List<Cart> cartItems;
  final AdressModel orderAdress;
  final OrderStatus orderStatus;

  OrderModel(this.totalAmount, this.cartItems, this.orderStatus, this.orderDate,
      this.orderClock, this.orderAdress);
}
