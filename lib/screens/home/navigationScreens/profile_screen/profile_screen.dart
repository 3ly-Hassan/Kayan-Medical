import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/authController/auth_cubit.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/controllers/homeCotroller/home_states.dart';
import 'package:kayan/screens/authScreen/auth_screen.dart';

import 'package:kayan/screens/order_screen/order_list_screen.dart';
import 'package:kayan/shared/shared.dart';

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
                  // final id = usersCollection.doc().id;
                  // FirestoreServices.saveProduct(Product(
                  //     id: id,
                  //     category: 'اخري',
                  //     name: 'ميزان المطبخ v-cooka',
                  //     details:
                  //         'يقيس حتي 5 كجم بدقة 1 جم امكانية تصفير القراءة واضافة اوزان جديدة مؤشر عند ضعف البطارية قابل للطي لسهولة التخزين شاشة ملونة',
                  //     imgUrl:
                  //         'https://lh3.googleusercontent.com/Ahej5vtFeKxMr3CKbm9o6PSh62gAPT6CdrlhNdoFIbGZGPUhRCyTkP4LP1GsHv2nMN9EdQWGxyEtJMHPisTU5KbAX0qvwmhNHVUoqv2VY8jsf9Q_I3WWhC1Sp_7Nh_7FuOe_wzD6Z55Ms-FFvnUwxDWOjXhRAhJVDiZaP_Vdwrqw5unEYUFTH4ZApOD1C9qgU_iH7WNWPUUNgvUTRrj_fTJTi0ofAjdHCLdQiI7q5im11Uw4RmnsxGSlhQ7PUtwd5jfZKFxgR17puH8JajVzUf34EA4VOE-Js5yGk0u8A8vjpeLrUNLhWSz4RnfcCYNzfAJARgueDbk5hQdvuNbVhx3kcJ-aydPQ7jbKUA2ZEWFPvDfGOhUAW92SNW95FAk-cXcR4I8kNi2iisLemjqJ250dgjmduCnxQDNwe8vUCWUmvS2HsrAgadjjiKeYbSiYQDUxYFemesg-ccqHosFQEjPyZmGnkY83kunZJF4F_o7FhONtqu4LBfWvMbNEFLjYa7BlH1x8r0N3ZpEo3DwRX4fbI4axSYWO_w04GJro0EpYafTvVqXb1JUyBAtcS28BCH1DFlGEnmFVlWghRjx6mvM4BLQC9LkvmpBujFl-vrnlkMloU57J9PkoI3FJGQ8MqUklFbup4EvlawPaaDl1ncdS-HL84Fo4i7k8O8GQnDtA1K2OwWURzGPTfYoe0k2fJVX0C7bVe78LIJdWcs4P7G9Ejq9jO-sqpsxcEWo-6u47rbcCW6vwCwKAr5VY3w=s440-no?authuser=0',
                  //     price: 380,
                  //     company: 'جرانزيا'));
                  // DateHelper.getTheArabicDay(DateTime.now());
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
                          HomeCubit.get(context).pageIndex = 0;
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