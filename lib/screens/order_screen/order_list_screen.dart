import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/screens/order_screen/order_card.dart';
import 'package:kayan/screens/order_screen/order_screen.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({Key? key}) : super(key: key);

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
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(
                                orderModel:
                                    HomeCubit.get(context).orders[index]),
                          ));
                    },
                    child: OrderListCard(
                        order: HomeCubit.get(context).orders[index]),
                  );
                },
                itemCount: HomeCubit.get(context).orders.length,
              ),
            ),
          )),
    );
  }
}
