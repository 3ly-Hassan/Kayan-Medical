import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/controllers/homeCotroller/home_states.dart';
import 'package:kayan/models/cart_model.dart';
import 'package:kayan/screens/home/navigationScreens/home_screen/tab_widget.dart';

import '../../../../models/product_model.dart';

class HomeListItem extends StatelessWidget {
  const HomeListItem(
      {Key? key, this.index, required this.product, this.quantity = 1})
      : super(key: key);
  final int? index;
  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 20),
      width: double.maxFinite,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 5,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontFamily: 'Cairo',
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF081305),
                        ),
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
                    maxLines: 2,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF081305),
                        ),
                  ),
                  Text(
                    'قراءة المزيد',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          color: Colors.lightGreen,
                        ),
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(
                              '00.',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF081305),
                                      ),
                            ),
                            Text(
                              product.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF081305),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      TabItem(
                        onTap: () {
                          HomeCubit.get(context)
                              .addToCart(Cart(product, quantity));
                        },
                        title: HomeCubit.get(context).inCart(product.id)
                            ? 'اضافة'
                            : 'شراء',
                        istabItem: false,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  height: double.maxFinite,
                  //padding: const EdgeInsets.all(8),
                  //alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(right: 10),
                  child: Hero(
                    tag: index!,
                    child: Image.asset(
                      product.imgUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: BlocBuilder<HomeCubit, HomeStates>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              HomeCubit.get(context).toggleFav(product);
                            },
                            child: Icon(
                              HomeCubit.get(context).isFav(product)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
