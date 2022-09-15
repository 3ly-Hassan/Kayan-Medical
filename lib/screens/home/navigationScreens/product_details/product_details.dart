import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/controllers/homeCotroller/home_states.dart';
import 'package:kayan/models/cart_model.dart';

import '../../../../models/product_model.dart';
import '../home_screen/tab_widget.dart';

class ProductDeatails extends StatelessWidget {
  const ProductDeatails({Key? key, required this.theTag, required this.product})
      : super(key: key);
  final int theTag;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Theme.of(context).scaffoldBackgroundColor),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: MaterialButton(
                      elevation: 0,
                      padding: const EdgeInsets.all(12),
                      minWidth: 0,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF081305),
                      ),
                    ),
                  ),
                  MaterialButton(
                    elevation: 0,
                    padding: const EdgeInsets.all(12),
                    onPressed: () {
                      HomeCubit.get(context).toggleFav(product);
                    },
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: BlocBuilder<HomeCubit, HomeStates>(
                      builder: (context, state) {
                        debugPrint(
                            HomeCubit.get(context).isFav(product).toString());
                        return Icon(
                          HomeCubit.get(context).isFav(product)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 250,
                      width: 250,
                      child: Hero(
                        tag: theTag,
                        child: Image.asset(product.imgUrl),
                      )),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                  child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 50, left: 30, right: 30, bottom: 5),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                product.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontFamily: 'Cairo',
                                      height: 1.2,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF081305),
                                    ),
                              ),
                            ),
                            Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    color:
                                        const Color(0xFF081305).withOpacity(.2),
                                    width: 1),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4),
                                child: Row(children: [
                                  const Icon(Icons.star, color: Colors.amber),
                                  Text(
                                    product.rate.toString(),
                                    style: const TextStyle(
                                        color: Color(0xFF081305),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'من ${product.company}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF081305),
                              ),
                        ),
                        Text(
                          product.details,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF081305),
                              ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20)),
                                margin: const EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  product.imgUrl,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20)),
                                margin: const EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  product.imgUrl,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20)),
                                margin: const EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  product.imgUrl,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              Divider(
                color: const Color(0xFF081305).withOpacity(.2),
                height: 1,
              ),
              Material(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Row(
                    children: [
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            product.price.toInt().toString(),
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF081305),
                                    ),
                          ),
                          Text(
                            '.00',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF081305),
                                    ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          HomeCubit.get(context).minusOne();
                        },
                        style: TextButton.styleFrom(
                            fixedSize: const Size(5, 5),
                            minimumSize: const Size(25, 30),
                            primary: Colors.white,
                            backgroundColor: const Color(0xFF081305)),
                        child: const Text('-'),
                      ),
                      BlocBuilder<HomeCubit, HomeStates>(
                        builder: (context, state) {
                          return Text(
                              HomeCubit.get(context).quantity.toString());
                        },
                      ),
                      TextButton(
                          onPressed: () {
                            HomeCubit.get(context).addOne();
                          },
                          style: TextButton.styleFrom(
                              fixedSize: const Size(5, 5),
                              minimumSize: const Size(25, 30),
                              primary: Colors.white,
                              backgroundColor: const Color(0xFF081305)),
                          child: const Text('+')),
                      const Spacer(),
                      BlocBuilder<HomeCubit, HomeStates>(
                        builder: (context, state) {
                          return TabItem(
                            title: HomeCubit.get(context).inCart(product.id)
                                ? 'اضافة'
                                : 'شراء',
                            istabItem: false,
                            color: Colors.lightGreen,
                            onTap: () {
                              HomeCubit.get(context).addToCart(Cart(
                                  product, HomeCubit.get(context).quantity));
                              HomeCubit.get(context).makeQuantityOne();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
