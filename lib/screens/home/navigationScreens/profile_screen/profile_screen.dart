import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/authController/auth_cubit.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/controllers/homeCotroller/home_states.dart';
import 'package:kayan/screens/authScreen/auth_screen.dart';

import 'package:kayan/screens/order_screen/order_list_screen.dart';
import 'package:kayan/shared/shared.dart';
import 'package:kayan/utility/date_helper.dart';

import '../../../adress_screen/adress_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Divider(
                color: Colors.lightGreen,
              ),
              PofileButton(
                onTap: () {
                  //FirestoreServices.getAllProducts();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Adress(),
                      ));
                  // FirestoreServices.saveProduct(Product(
                  //     id: 5,
                  //     category: 'اخري',
                  //     name: 'شفاط ثدي ديجتال GentleFeed',
                  //     details:
                  //         "مودين للشفط (التدليك والشفط) - سهولة الاستخدام ولا يسبب الم للثدي اثناء الشفط خامات عالية الجودة لضمان وجبة غذائية صحية متكاملة لطفلك",
                  //     imgUrl: "https://t.ly/Eeql",
                  //     price: 2600,
                  //     company: 'جرانزيا',
                  //     rate: 4.7));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const Adress(),
                  //     ));
                },
                label: 'العنوانين',
                icon: Icons.map_outlined,
              ),
              const Divider(
                color: Colors.lightGreen,
              ),
              PofileButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdersListScreen(),
                      ));
                },
                label: 'الطلبات',
                icon: Icons.list_alt_outlined,
              ),
              const Divider(
                color: Colors.lightGreen,
              ),
              PofileButton(
                onTap: () {
                  DateHelper.getTheArabicDay(DateTime.now());
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const OrdersListScreen(),
                  //     ));
                },
                label: 'الملف الشخصي',
                icon: Icons.person_outline_outlined,
              ),
              const Divider(
                color: Colors.lightGreen,
              ),
              BlocConsumer<HomeCubit, HomeStates>(
                listener: (context, state) {
                  if (state is LogoutError) {
                    showCentralToast(
                        text: state.error.toString(), state: ToastStates.error);
                  } else if (state is LogoutSuccess) {
                    showCentralToast(
                        text: 'تم تسجيل الخروج بنجاح',
                        state: ToastStates.success);
                    //Navigator.pop(context);
                    //HomeCubit.get(context).tabController.jumpToTab(0);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => AuthCubit(),
                            child: const AuthScreen(),
                          ),
                        ),
                        (route) => false);
                  }
                },
                builder: (context, state) => state is LogoutLoadding
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      )
                    : PofileButton(
                        onTap: () {
                          HomeCubit.get(context).logOut();
                        },
                        label: 'تسجيل الخروج',
                        icon: Icons.logout_outlined,
                      ),
              ),
              // PofileButton(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const OrdersListScreen(),
              //         ));
              //   },
              //   label: 'تسجيل الخروج',
              //   icon: Icons.logout_outlined,
              // ),
              Container(
                padding: const EdgeInsets.only(right: 16, bottom: 8),
                alignment: Alignment.bottomRight,
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Text(
                  'للتواصل وسياسة الاستخدام',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 17,
                        color: Colors.lightGreen,
                        fontFamily: 'Cairo',
                      ),
                ),
              ),
              const Divider(
                color: Colors.lightGreen,
              ),
              PofileButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdersListScreen(),
                      ));
                },
                label: 'للشكاوي والمقترحات',
                icon: Icons.help_center_outlined,
              ),
              const Divider(
                color: Colors.lightGreen,
              ),
              PofileButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdersListScreen(),
                      ));
                },
                label: 'سياسة الخصوصية',
                icon: Icons.privacy_tip_outlined,
              ),
              const Divider(
                color: Colors.lightGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PofileButton extends StatelessWidget {
  const PofileButton({
    Key? key,
    required this.onTap,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        children: [
          Icon(icon),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                alignment: Alignment.centerRight,
                primary: Theme.of(context).scaffoldBackgroundColor,
                fixedSize: const Size(double.infinity, 60),
                elevation: 0),
            onPressed: () {
              onTap(); //HomeCubit.get(context).logOut();
            },
            child: Text(
              label,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontFamily: 'Cairo',
                  ),
            ),
          ),
        ],
      ),
    );
  }
}


 // child: BlocConsumer<HomeCubit, HomeStates>(
              //   listener: (context, state) {
              //     if (state is LogoutError) {
              //       showCentralToast(
              //           text: state.error.toString(), state: ToastStates.error);
              //     } else if (state is LogoutSuccess) {
              //       showCentralToast(
              //           text: 'تم تسجيل الخروج بنجاح', state: ToastStates.success);
              //       //Navigator.pop(context);
              //       //HomeCubit.get(context).tabController.jumpToTab(0);
              //       Navigator.pushAndRemoveUntil(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => BlocProvider(
              //               create: (context) => AuthCubit(),
              //               child: const AuthScreen(),
              //             ),
              //           ),
              //           (route) => false);
              //     }
              //   },
              //   builder: (context, state) => state is LogoutLoadding
              //       ? const Center(
              //           child: CircularProgressIndicator(color: Colors.green),
              //         )
              //       : Text(
              //           'تسجيل الخروج',
              //           style: Theme.of(context).textTheme.headline6!.copyWith(
              //                 color: Colors.white,
              //                 fontFamily: 'Cairo',
              //               ),
              //         ),
              // ),