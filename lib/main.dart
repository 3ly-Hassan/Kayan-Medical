import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/authController/auth_cubit.dart';
import 'package:kayan/screens/authScreen/auth_screen.dart';
import 'package:kayan/screens/home/main_screen.dart';
import 'package:kayan/screens/home/navigationScreens/onBoardingScreen/on_boarding_screen.dart';
import 'package:kayan/utility/cash_helper.dart';
import 'package:kayan/utility/light_theme.dart';
import 'controllers/homeCotroller/home_cubit.dart';
import 'firebase_options.dart';
import 'services/fiestore_collection.dart';
import 'utility/bloc_observer.dart';
import 'utility/constatns.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CacheHelper.init();
  // await NotificationHelper.initializeNotification();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;
//  Widget home;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // token = CacheHelper.getData(key: 'token');
  // role = CacheHelper.getData(key: 'role');

  if (onBoarding != null) {
    if (FirebaseAuth.instance.currentUser != null) {
      if (kDebugMode) {
        print('Home Here');
      }
      userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot documentSnapshot =
          await usersCollection.doc(userId).get();
      userName = documentSnapshot['name'];
      widget = const MainScreen();
    } else {
      if (kDebugMode) {
        print('Auth Here');
      }
      widget = BlocProvider(
        create: (context) => AuthCubit(),
        child: const AuthScreen(),
      );
    }
  } else {
    if (kDebugMode) {
      print('OnBoarding Here');
    }
    //home = const OnBoarding();
    widget = const OnBoarding();
  }

  // runApp(MyApp(
  //   isDark: isDark,
  //   startWidget: widget,
  // ));

  Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.isDark, this.startWidget, this.home})
      : super(key: key);
  final bool? isDark;
  final Widget? startWidget;
  final Widget? home;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()..init())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kayan',
        theme: getLightTheme(context),
        home: startWidget,
      ),
    );
  }
}

// class AuthOrHome extends StatelessWidget {
//   const AuthOrHome({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.hasData) {
//           return BlocProvider(
//               create: (context) => HomeCubit()..init(),
//               child: const MainScreen());
//         } else {
//           return BlocProvider(
//             create: (context) => AuthCubit(),
//             child: const AuthScreen(),
//           );
//         }
//       },
//     );
//   }
// }
