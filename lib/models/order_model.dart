import 'package:kayan/models/adress_model.dart';
import 'package:kayan/models/cart_model.dart';

class OrderModel {
  double? totalAmount;
  String? orderCreateDate;
  String? orderArriveDate;
  String? id;
  String? adressId;
  List<Cart>? cartItems;
  AdressModel? orderAdress;
  String? orderStatus;

  OrderModel(
      this.totalAmount,
      this.cartItems,
      this.orderStatus,
      this.id,
      this.orderCreateDate,
      this.adressId,
      this.orderArriveDate,
      this.orderAdress);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['totalAmount'] = totalAmount;
    data['orderCreateDate'] = orderCreateDate;
    data['orderStatus'] = orderStatus;
    data['orderArriveDate'] = orderArriveDate;
    data['orderId'] = id;
    data['adressId'] = adressId;

    return data;
  }

  OrderModel.fromJson(Map<String, dynamic> data, AdressModel adressModel) {
    id = data['id'];
    totalAmount = data['totalAmount'];
    orderCreateDate = data['orderCreateDate'];
    orderArriveDate = data['orderArriveDate'];
    orderStatus = data['orderStatus'];
    orderAdress = adressModel;
  }
}
