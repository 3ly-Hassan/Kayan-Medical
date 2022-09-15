import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showCentralToast({
  @required String? text,
  @required ToastStates? state,
}) =>
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state!),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { success, error, warning }

enum OrderStatus { review, shipping, onRoad, completed }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

bool checkStatusComplete(OrderStatus orderStatus) {
  return orderStatus == OrderStatus.completed;
}

bool checkStatusoRoad(OrderStatus orderStatus) {
  return orderStatus == OrderStatus.onRoad || checkStatusComplete(orderStatus);
}

bool checkStatusShipping(OrderStatus orderStatus) {
  return orderStatus == OrderStatus.shipping || checkStatusoRoad(orderStatus);
}
