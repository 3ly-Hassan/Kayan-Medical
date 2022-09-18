import 'package:kayan/models/adress_model.dart';
import 'package:kayan/models/cart_model.dart';
import 'package:kayan/shared/shared.dart';

class OrderModel {
  double? totalAmount;
  String? orderCreateDate;
  String? orderArriveDate;
  String? id;
  List<Cart>? cartItems;
  AdressModel? orderAdress;
  String? orderStatus;

  OrderModel(this.totalAmount, this.cartItems, this.orderStatus, this.id,
      this.orderCreateDate, this.orderAdress, this.orderArriveDate);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['totalAmount'] = totalAmount;
    data['orderCreateDate'] = orderCreateDate;
    data['orderStatus'] = orderStatus;
    data['orderArriveDate'] = orderArriveDate;
    data['adressId'] = id;

    return data;
  }

  OrderModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    totalAmount = data['totalAmount'];
    orderCreateDate = data['orderCreateDate'];
    orderArriveDate = data['orderArriveDate'];
    orderStatus = data['orderStatus'];
  }
}
