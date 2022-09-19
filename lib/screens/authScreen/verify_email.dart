import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/authController/auth_cubit.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/screens/home/main_screen.dart';
import 'package:kayan/shared/shared.dart';

import 'auth_screen.dart';

class VerifyEmailSceen extends StatefulWidget {
  const VerifyEmailSceen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailSceen> createState() => _VerifyEmailSceenState();
}

class _VerifyEmailSceenState extends State<VerifyEmailSceen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;

  Timer? timer;

  @override
  void initState() {
    debugPrint('vvv');
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      showCentralToast(text: 'حدث خطأ ما', state: ToastStates.error);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const MainScreen()
      : Scaffold(
          backgroundColor: Colors.white,
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 60.0,
                      horizontal: 32.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ' يجب تأكيد بريدك الالكتروني قبل الاستمرار لقد تم ارسال رابط التاكيد الي بريدك الالكتروني',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Cairo',
                                    color: Colors.grey),
                          ),
                          const SizedBox(height: 40.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.lightGreen,
                                fixedSize: const Size(double.maxFinite, 60)),
                            onPressed:
                                canResendEmail ? sendVerificationEmail : () {},
                            child: Text(
                              'اعادة الارسال',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                  ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              HomeCubit.get(context).logOut().then((value) =>
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => AuthCubit(),
                                        child: const AuthScreen(),
                                      ),
                                    ),
                                  ));
                            },
                            child: Text(
                              'تسجيل الخروج',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.lightGreen,
                                    fontFamily: 'Cairo',
                                  ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        );

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
