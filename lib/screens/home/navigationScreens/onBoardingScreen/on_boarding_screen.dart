import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/authController/auth_cubit.dart';
import 'package:kayan/models/on_boarding_model.dart';
import 'package:kayan/screens/authScreen/auth_screen.dart';

import '../../../../utility/cash_helper.dart';
import 'widgets/dot.dart';
import 'widgets/on_boardig_content.dart';

class OnBoarding extends StatefulWidget {
  static String routeName = "/onBoarding";
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onBoardingData.length,
                onPageChanged: (index) {
                  _pageIndex = index;
                  setState(() {});
                },
                itemBuilder: (context, index) => OnBoardingContent(
                    imgPath: onBoardingData[index].imgPath,
                    header: onBoardingData[index].title,
                    body: onBoardingData[index].body),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      CacheHelper.saveData(key: 'onBoarding', value: true).then(
                        (value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => AuthCubit(),
                              child: const AuthScreen(),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'تخطي',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo',
                          color: Colors.red),
                    ),
                  ),
                  const Spacer(),
                  ...List.generate(
                      onBoardingData.length,
                      (index) => InkWell(
                            onTap: () => _pageController.animateToPage(index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease),
                            child: Dot(
                              isActive: _pageIndex == index,
                            ),
                          )),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          primary: Colors.lightGreen),
                      onPressed: () {
                        _pageIndex != 2
                            ? _pageController.nextPage(
                                duration: const Duration(microseconds: 300),
                                curve: Curves.ease)
                            : CacheHelper.saveData(
                                    key: 'onBoarding', value: true)
                                .then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => AuthCubit(),
                                        child: const AuthScreen(),
                                      ),
                                    )));
                      },
                      child: Icon(
                        _pageIndex != 2
                            ? Icons.arrow_right_alt_outlined
                            : Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
//'ستجد كل ما تبحث عنه وتحتاجه\n هنا في مكان واحد'
// " هنا انت هتلاقي مجموعة كبيرة من المنتجات الطبية مصنفة تصنيف جيد يساعدك للوصول لما تحتاج بسهولة"