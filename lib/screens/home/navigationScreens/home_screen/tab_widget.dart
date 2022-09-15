import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controllers/homeCotroller/home_cubit.dart';
import '../../../../controllers/homeCotroller/home_states.dart';

class TabItem extends StatelessWidget {
  const TabItem(
      {Key? key,
      required this.title,
      this.onTap,
      this.index,
      this.istabItem = true,
      this.color = const Color(0xFF081305)})
      : super(key: key);
  final String title;
  final int? index;
  final bool istabItem;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);

    return InkWell(
      onTap: () {
        if (istabItem) {
          cubit.tabChange(index);
          cubit.findCategory(title);
        } else {
          onTap!();
        }
      },
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 12),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
            decoration: BoxDecoration(
              color: index == cubit.tabIndex || !istabItem
                  ? color
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: index == cubit.tabIndex || !istabItem
                        ? Colors.white
                        : color,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
