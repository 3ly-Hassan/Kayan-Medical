import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/services/firabase_auth_service.dart';
import 'package:kayan/services/firestore_services.dart';
import 'package:kayan/utility/constatns.dart';

import '../../services/fiestore_collection.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(MedLoginInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loginPage = true;
  User? user;
  IconData suffix = Icons.visibility_off_outlined;
  bool isSecure = true;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode matchPasswordFocusNode;

  void togglebetweenloginAndSignUp() {
    loginPage = !loginPage;
    emit(LoginPageToggled());
  }

  void fieldSubmitted(context, focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  Future<void> login() async {
    emit(MedLoginLoadingState());
    try {
      user = await AuthServices.login(
          emailController.text.trim(), passwordController.text.trim());
      usersCollection
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userId = user!.uid;
          userName = documentSnapshot['name'];
          emit(MedLoginSuccessState());
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains(
          'The password is invalid or the user does not have a password.')) {
        emit(MedLoginErrorState(error: 'كلمة السر التي ادخلتها غير صحيحة'));
      } else if (e.message!.contains(
          'There is no user record corresponding to this identifier')) {
        emit(MedLoginErrorState(
            error: 'البريد الالكتروني الذي ادخلته غير موجود'));
      } else if (e.message!
          .contains('We have blocked all requests from this device due to')) {
        emit(MedLoginErrorState(error: 'حاول مرة اخري ف وقت لاحق'));
      } else {
        emit(MedLoginErrorState(error: e.message));
      }
      if (kDebugMode) {
        print(e.toString());
      }
    } catch (e) {
      emit(MedLoginErrorState(error: e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void userRegister() async {
    emit(MedLoginLoadingState());
    try {
      user = await AuthServices.signUp(
          emailController.text.trim(), passwordController.text.trim());
      await FirestoreServices.saveUser(
          emailController.text, nameController.text.trim(), user!.uid);
      userName = nameController.text.trim();
      userId = user!.uid;
      emit(MedLoginSuccessState());
      if (user == null) {
        emit(MedLoginErrorState());
      }
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains('The email address is already')) {
        emit(MedLoginErrorState(error: "هذا البريد الالكتروني موجود بالفعل"));
      } else if (e.message!
          .contains('We have blocked all requests from this device due to')) {
        emit(MedLoginErrorState(error: 'حاول مرة اخري ف وقت لاحق'));
      } else {
        emit(MedLoginErrorState(error: e.message));
      }
      if (kDebugMode) {
        print(e.toString());
      }
    } catch (e) {
      emit(MedLoginErrorState(error: 'حدث خطأ ما'));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void changePasswordVisibility() {
    isSecure = !isSecure;
    suffix =
        !isSecure ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(MedChangePasswordVisibilityState());
  }

  // void userLogin( requestModel) {
  //   emit(MedLoginLoadingState());
  //   _login(requestModel).then((value) {
  //     if () {
  //       print('ali..............');
  //       emit(MedLoginErrorState());
  //       return;
  //     } else {
  //       if (value.token == 'ERROR')
  //         emit(MedLoginErrorState(error: value.msg));
  //       else {
  //         print(' ############${value.token}##########');
  //         emit(MedLoginSuccessState(value));
  //       }
  //     }
  //   }).catchError((e) {
  //     emit(MedLoginErrorState(error: e));
  //   });
  // }

  // bool isRole = true;
  // notRole(value) {
  //   isRole = value;
  //   emit(RoleState());
  // }

  // int? selectedItem;
  // void selectRole(int i) {
  //   selectedItem = i;
  //   emit(SelectState());
  // }
}
