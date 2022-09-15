import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/homeCotroller/home_states.dart';
import 'package:kayan/screens/home/navigationScreens/home_screen/tab_widget.dart';
import 'package:kayan/shared/shared.dart';
import 'package:kayan/utility/constatns.dart';

import '../../../../controllers/homeCotroller/home_cubit.dart';
import '../product_details/product_details.dart';
import 'home_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('الأكثر مبيعا',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF081305))),
                    Text(
                      'اهلا $userName',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF081305),
                          ),
                    ),
                  ],
                ),
                Text(
                  'الاختيار المثالي ليك ولأسرتك!',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF081305),
                      ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 60,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF081305),
                      ),
                      filled: true,
                      hintText: 'ابحث عن كل ما تريد ',
                      fillColor: Colors.white,
                      enabled: false,
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    focusNode: AlwaysDisabledFocusNode(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => TabItem(
                      title: tabsTitles[index],
                      index: index,
                    ),
                    itemCount: tabsTitles.length,
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<HomeCubit, HomeStates>(
                  builder: (context, state) {
                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDeatails(
                                          theTag: index,
                                          product: cubit.tabList[index])));
                            },
                            child: HomeListItem(
                              index: index,
                              product: cubit.tabList[index],
                            )),
                        itemCount: cubit.tabList.length,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
