import 'package:flutter/material.dart';
import 'package:kayan/models/order_model.dart';
import 'package:kayan/shared/shared.dart';

class OrderListCard extends StatelessWidget {
  const OrderListCard({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: checkStatusComplete(order.orderStatus!)
          ? Colors.green
          : checkStatusoRoad(order.orderStatus!)
              ? Colors.yellowAccent
              : checkStatusShipping(order.orderStatus!)
                  ? Colors.yellow
                  : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(
                  Icons.alarm,
                  color: Colors.black,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'يصل يوم ${order.orderArriveDate} الساعة مساء',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontFamily: 'Cairo', height: 1),
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Text(
                      '${order.orderAdress!.buildNo} ${order.orderAdress!.streetName}, ${order.orderAdress!.city}, ${order.orderAdress!.state}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontFamily: 'Cairo'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
