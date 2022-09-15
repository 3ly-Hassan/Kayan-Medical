import 'package:flutter/material.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import '../home_screen/home_list_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.lightGreen,
                      ),
                      filled: true,
                      hintText: ' ابحث عن كل ما تريد هنا',
                      fillColor: Colors.white,
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    // focusNode: AlwaysDisabledFocusNode(),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HomeListItem(
                        index: index,
                        product: homeCubit.products[index],
                      );
                    },
                    itemCount: homeCubit.products.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
