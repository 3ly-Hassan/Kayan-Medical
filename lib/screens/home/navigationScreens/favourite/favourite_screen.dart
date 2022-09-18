import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/homeCotroller/home_states.dart';

import '../../../../controllers/homeCotroller/home_cubit.dart';
import '../home_screen/home_list_item.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
                top: 20,
              ),
              child: BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HomeListItem(
                        index: index,
                        product: homeCubit.favProduct[index],
                      );
                    },
                    itemCount: homeCubit.favProduct.length,
                  );
                },
              )),
        ),
      ),
    );
  }
}
