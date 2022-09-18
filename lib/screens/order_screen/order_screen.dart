import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayan/models/order_model.dart';
import 'package:kayan/shared/shared.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key, required this.orderModel}) : super(key: key);
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              //statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.purple.withOpacity(.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 25),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.alarm,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'يصل يوم ${orderModel.orderArriveDate} الساعة  مساء',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontFamily: 'Cairo', height: 1),
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
                                  Text(
                                    '${orderModel.orderAdress!.buildNo} ${orderModel.orderAdress!.streetName}, ${orderModel.orderAdress!.city}, ${orderModel.orderAdress!.state}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontFamily: 'Cairo'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'حالة الطلب ',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontFamily: 'Cairo', height: 2),
                    ),
                    const SizedBox(height: 20),
                    const OrderStatusItem(
                      label: 'يتم مراجعة طلبك',
                      enabled: true,
                    ),
                    OrderStatusItem(
                      label: 'تم شحن طلبك',
                      enabled: checkStatusShipping(orderModel.orderStatus!),
                    ),
                    OrderStatusItem(
                      label: 'طلبك في الطريق اليك',
                      enabled: checkStatusoRoad(orderModel.orderStatus!),
                    ),
                    OrderStatusItem(
                      label: 'تم تسليم الطلب بنجاح',
                      enabled: checkStatusComplete(orderModel.orderStatus!),
                      last: true,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class OrderStatusItem extends StatelessWidget {
  const OrderStatusItem({
    Key? key,
    required this.enabled,
    required this.label,
    this.last = false,
  }) : super(key: key);
  final bool enabled;
  final String label;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Icon(Icons.rate_review_sharp,
              color: enabled ? Colors.lightGreen : Colors.grey),
          const SizedBox(width: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontFamily: 'Cairo',
                color: enabled ? Colors.lightGreen : Colors.grey),
          ),
        ]),
        if (!last)
          SizedBox(
            height: 60,
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  children: [
                    (VerticalDivider(
                      thickness: 2,
                      width: 2,
                      color: enabled ? Colors.lightGreen : Colors.grey,
                    ))
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
