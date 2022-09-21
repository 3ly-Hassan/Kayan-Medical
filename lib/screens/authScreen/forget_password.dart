import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kayan/shared/shared.dart';
import 'package:kayan/utility/constatns.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _controller;
  late FocusNode focusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 60.0,
                horizontal: 32.0,
              ),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'استعادة كلمة السر',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo',
                            color: Colors.lightGreen),
                      ),
                      const SizedBox(height: 80.0),
                      TextFormField(
                        controller: _controller,
                        focusNode: focusNode,
                        autofocus: true,
                        onEditingComplete: () => _resetPassword(),
                        textInputAction: TextInputAction.done,
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
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen,
                            fixedSize: const Size(double.maxFinite, 60)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _resetPassword();
                          }
                        },
                        child: Text(
                          'ارسال',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  void _resetPassword() {
    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _controller.text.trim());
      focusNode.unfocus();
      showCentralToast(
          text: 'تم ارسال رابط اعادة كلمة السر', state: ToastStates.success);
    } catch (e) {
      showCentralToast(text: 'حدث خطأ ما', state: ToastStates.error);
    }
  }
}
