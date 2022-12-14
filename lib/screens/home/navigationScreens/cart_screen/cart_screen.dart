import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/controllers/homeCotroller/home_states.dart';
import 'package:kayan/models/cart_model.dart';
import 'package:kayan/screens/home/navigationScreens/home_screen/home_list_item.dart';

import '../../../adress_screen/adress_screen.dart';
import '../product_details/product_details.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cartList = HomeCubit.get(context).cartList;
    // final cartItems = cartList.values.toList();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
              return HomeCubit.get(context).cartList.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDeatails(
                                                    theTag: index,
                                                    product:
                                                        HomeCubit.get(context)
                                                            .cartList
                                                            .values
                                                            .toList()[index]
                                                            .product)));
                                  },
                                  child: HomeListItem(
                                      product: HomeCubit.get(context)
                                          .cartList
                                          .values
                                          .toList()[index]
                                          .product,
                                      index: index)),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                color: Colors.lightGreen,
                                child: BlocBuilder<HomeCubit, HomeStates>(
                                  builder: (context, state) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            if (HomeCubit.get(context)
                                                    .cartList
                                                    .values
                                                    .toList()[index]
                                                    .quantity >
                                                1) {
                                              HomeCubit.get(context).addToCart(
                                                  Cart(
                                                      HomeCubit.get(context)
                                                          .cartList
                                                          .values
                                                          .toList()[index]
                                                          .product,
                                                      -1));
                                            } else {
                                              HomeCubit.get(context)
                                                  .removeCartItem(
                                                      HomeCubit.get(context)
                                                          .cartList
                                                          .values
                                                          .toList()[index]
                                                          .product
                                                          .id!);
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                              minimumSize: const Size(25, 30),
                                              primary: Colors.white,
                                              backgroundColor:
                                                  const Color(0xFF081305)),
                                          child: Text(HomeCubit.get(context)
                                                      .cartList
                                                      .values
                                                      .toList()[index]
                                                      .quantity >
                                                  1
                                              ? '-'
                                              : '??????'),
                                        ),
                                        BlocBuilder<HomeCubit, HomeStates>(
                                          builder: (context, state) {
                                            return Text(
                                              '${HomeCubit.get(context).cartList.values.toList()[index].quantity}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            );
                                          },
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              HomeCubit.get(context).addToCart(
                                                  Cart(
                                                      HomeCubit.get(context)
                                                          .cartList
                                                          .values
                                                          .toList()[index]
                                                          .product,
                                                      1));
                                            },
                                            style: TextButton.styleFrom(
                                                fixedSize: const Size(5, 5),
                                                minimumSize: const Size(25, 30),
                                                primary: Colors.white,
                                                backgroundColor:
                                                    const Color(0xFF081305)),
                                            child: const Text('+')),
                                        Text(
                                          '${HomeCubit.get(context).cartList.values.toList()[index].product.price! * HomeCubit.get(context).cartList.values.toList()[index].quantity} ????????',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          itemCount: HomeCubit.get(context)
                              .cartList
                              .values
                              .toList()
                              .length,
                        )),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                HomeCubit.get(context).emptyCart();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                color: Colors.red,
                                child: const Text(
                                  '??????????',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Adress(
                                          fromCart: true,
                                        ),
                                      ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  color: const Color(0xFF081305),
                                  child: Text(
                                    ' ?????????????? ?????????? ??????????   ${HomeCubit.get(context).totalAmount(HomeCubit.get(context).cartList.values.toList())} ????????',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Center(
                      child: SvgPicture.asset(
                      'assets/images/noOrders.svg',
                      height: 250,
                    ));
            }),
          ),
        ));
  }
}
