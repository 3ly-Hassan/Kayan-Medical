import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/controllers/homeCotroller/home_states.dart';
import '../home_screen/home_list_item.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
//  Timer searchOnStoppedTyping;

//     _onChangeHandler(value ) {
//         const duration = Duration(milliseconds:800); // set the duration that you want call search() after that.
//         if (searchOnStoppedTyping != null) {
//             setState(() => searchOnStoppedTyping.cancel()); // clear timer
//         }
//         setState(() => searchOnStoppedTyping = new Timer(duration, () => search(value)));
//     }

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
                    controller: _controller,
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
                    textInputAction: TextInputAction.search,
                    onEditingComplete: () {
                      HomeCubit.get(context).search(_controller.text.trim());
                    },
                    onChanged: (String? keyWord) {
                      if (keyWord == null || keyWord == '') {
                        HomeCubit.get(context).search(keyWord);
                      }
                      // Future.delayed(const Duration(seconds: 2)).then(
                      //     (value) => HomeCubit.get(context).search(keyWord));
                    },
                    // focusNode: AlwaysDisabledFocusNode(),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeStates>(
                    builder: (context, state) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return HomeListItem(
                            index: index,
                            product: homeCubit.searchItems[index],
                          );
                        },
                        itemCount: homeCubit.searchItems.length,
                      );
                    },
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
