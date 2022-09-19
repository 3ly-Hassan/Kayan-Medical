import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/authController/auth_cubit.dart';
import 'package:kayan/controllers/authController/auth_states.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/screens/authScreen/verify_email.dart';
import 'package:kayan/screens/home/main_screen.dart';
import '../../shared/shared.dart';
import '../../utility/constatns.dart';
import 'forget_password.dart';

class AuthScreen extends StatefulWidget {
  static String routeName = '/Auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  @override
  void dispose() {
    AuthCubit.get(context).emailController.dispose();
    AuthCubit.get(context).passwordController.dispose();
    AuthCubit.get(context).passwordFocusNode.dispose();
    AuthCubit.get(context).emailFocusNode.dispose();
    AuthCubit.get(context).matchPasswordFocusNode.dispose();
    AuthCubit.get(context).nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    AuthCubit.get(context).emailController = TextEditingController();
    AuthCubit.get(context).passwordController = TextEditingController();
    AuthCubit.get(context).nameController = TextEditingController();
    AuthCubit.get(context).emailFocusNode = FocusNode();
    AuthCubit.get(context).passwordFocusNode = FocusNode();
    AuthCubit.get(context).matchPasswordFocusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final cubit = AuthCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is MedLoginSuccessState) {
            showCentralToast(
              text: 'تم الدخول بنجاح',
              state: ToastStates.success,
            );
            HomeCubit.get(context).init();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const VerifyEmailSceen(),
                ));
          } else if (state is MedLoginErrorState) {
            showCentralToast(
              text: state.error,
              state: ToastStates.error,
            );
            if (kDebugMode) {
              print(state.error);
            }
          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 60.0,
                  horizontal: 32.0,
                ),
                child: Form(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    // physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cubit.loginPage ? 'تسجيل الدخول' : 'إنشاء حساب جديد',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Cairo',
                                  color: Colors.lightGreen),
                        ),
                        const SizedBox(height: 80.0),
                        !cubit.loginPage
                            ? TextFormField(
                                controller: cubit.nameController,
                                onEditingComplete: () => cubit.fieldSubmitted(
                                    context, cubit.emailFocusNode),
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return kNameNullError;
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'الاسم',
                                  hintText: 'اسمك',
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 24.0),
                        TextFormField(
                          controller: cubit.emailController,
                          focusNode: cubit.emailFocusNode,
                          onEditingComplete: () => cubit.fieldSubmitted(
                              context, cubit.passwordFocusNode),
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return kEmailNullError;
                            } else if (!emailValidatorRegExp.hasMatch(val)) {
                              return kInvalidEmailError;
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'البريد الالكتروني',
                            hintText: 'قم بادخال بريدك الالكتروني',
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        TextFormField(
                          onEditingComplete: () => !cubit.loginPage
                              ? cubit.fieldSubmitted(
                                  context, cubit.matchPasswordFocusNode)
                              : FocusManager.instance.primaryFocus?.unfocus(),
                          textInputAction:
                              !cubit.loginPage ? TextInputAction.next : null,
                          controller: cubit.passwordController,
                          focusNode: cubit.passwordFocusNode,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return kPassNullError;
                            } else if (val.length < 8) {
                              return kShortPassError;
                            }
                            return null;
                          },
                          obscureText: cubit.isSecure,
                          decoration: InputDecoration(
                              labelText: 'كلمة السر',
                              hintText: 'قم بادخال كلمة السر',
                              suffixIcon: InkWell(
                                onTap: () {
                                  cubit.changePasswordVisibility();
                                },
                                child: Icon(
                                  cubit.suffix,
                                  color: Colors.lightGreen,
                                ),
                              ),
                              suffixIconColor: Colors.lightGreen),
                        ),
                        const SizedBox(height: 24.0),
                        !cubit.loginPage
                            ? TextFormField(
                                //controller: cubit.passwordController,
                                focusNode: cubit.matchPasswordFocusNode,
                                validator: (val) {
                                  if (val != cubit.passwordController.text) {
                                    return kMatchPassError;
                                  }

                                  return null;
                                },
                                obscureText: cubit.isSecure,
                                decoration: const InputDecoration(
                                  labelText: 'أعد ادخال كلمة السر',
                                  hintText: 'اعد ادخال كلمة السر',
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 16.0),
                        if (cubit.loginPage)
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Text(
                                'نسيت كلمة السر ؟',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Cairo',
                                        color: Colors.lightGreen),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPasswordScreen()));
                              },
                            ),
                          ),
                        const SizedBox(height: 24.0),
                        state is MedLoginLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.lightGreen,
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.lightGreen,
                                    fixedSize:
                                        const Size(double.maxFinite, 60)),
                                onPressed: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    if (cubit.loginPage) {
                                      cubit.login();
                                    } else {
                                      cubit.userRegister();
                                    }
                                  }
                                },
                                child: Text(
                                  cubit.loginPage
                                      ? 'تسجيل الدخول'
                                      : 'انشاء حساب ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: Colors.white,
                                        fontFamily: 'Cairo',
                                      ),
                                ),
                              ),
                        const SizedBox(height: 16.0),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            child: Text(
                              cubit.loginPage
                                  ? 'ليس لديك حساب؟ قم بالتسجيل '
                                  : 'لديك حساب بالفعل؟ قم بتسجيل الدخول',
                            ),
                            onTap: () {
                              cubit.formKey.currentState!.reset();
                              cubit.emailController.clear();
                              cubit.passwordController.clear();
                              cubit.nameController.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                              cubit.togglebetweenloginAndSignUp();
                            },
                          ),
                        ),
                        // const SizedBox(height: 20),
                        // Align(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       cubit.loginPage
                        //           ? 'او قم بالتسجل عن طريق '
                        //           : 'او قم بانشاء الحساب بواسطة ',
                        //       style: Theme.of(context).textTheme.subtitle1,
                        //     )),
                        // const SizedBox(height: 16.0),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       height: 80,
                        //       width: 80,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(16.0),
                        //         color: Colors.white,
                        //       ),
                        //       child: const Icon(
                        //         Icons.facebook_outlined,
                        //       ),
                        //     ),
                        //     // const SizedBox(width: 16.0),
                        //     // Container(
                        //     //   height: 80,
                        //     //   width: 80,
                        //     //   decoration: BoxDecoration(
                        //     //     borderRadius: BorderRadius.circular(16.0),
                        //     //     color: Colors.white,
                        //     //   ),
                        //     //   child: const Icon(Icons.add),
                        //     // ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
