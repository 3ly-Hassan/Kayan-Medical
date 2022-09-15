import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kayan/controllers/homeCotroller/home_cubit.dart';
import 'package:kayan/controllers/homeCotroller/home_states.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';
  //late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              //statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Theme.of(context).scaffoldBackgroundColor),
        ),
        body: PageView.builder(
            controller: cubit.tabController,
            itemCount: cubit.bodyPages.length,
            onPageChanged: (index) {
              cubit.bodyChange(index);
            },
            itemBuilder: (context, index) => cubit.bodyPages[index]),
        bottomNavigationBar: BlocBuilder<HomeCubit, HomeStates>(
          builder: (context, state) {
            return Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:
                        cubit.pageIndex == 0 || cubit.tabController.page == 0
                            ? [
                                BoxShadow(
                                    offset: const Offset(0, -70),
                                    blurRadius: 150,
                                    spreadRadius: 60,
                                    color: Colors.black.withOpacity(.8))
                              ]
                            : []),
                child: GNav(
                  tabActiveBorder: Border.all(
                    color: Colors.lightGreen,
                  ),
                  onTabChange: (index) {
                    cubit.changePageIndex(index);
                  },
                  selectedIndex: cubit.pageIndex,
                  tabs: _navBarsItems(context),
                  tabBorderRadius: 10,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(6),
                  gap: 8,
                  activeColor: Colors.lightGreen,
                  color: CupertinoColors.systemGrey,
                ));
          },
        ));
    // return PersistentTabView(
    //   context,

    //   controller: cubit.tabController,
    //   screens: cubit.buildScreens(),
    //   items: _navBarsItems(),
    //   confineInSafeArea: true,
    //   backgroundColor: Colors.white, // Default is Colors.white.
    //   handleAndroidBackButtonPress: true, // Default is true.
    //   resizeToAvoidBottomInset:
    //       true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    //   stateManagement: true, // Default is true.
    //   hideNavigationBarWhenKeyboardShows:
    //       true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    //   decoration: NavBarDecoration(
    //       borderRadius: BorderRadius.circular(5.0),
    //       colorBehindNavBar: Colors.white,
    //       boxShadow: [
    //         BoxShadow(
    //             offset: const Offset(0, -70),
    //             blurRadius: 150,
    //             spreadRadius: 60,
    //             color: Colors.black.withOpacity(.8)),
    //         // BoxShadow(offset: Offset(-100, -50), blurRadius: 1000),
    //         // BoxShadow(offset: Offset(100, -50), blurRadius: 1000),
    //       ]),
    //   popAllScreensOnTapOfSelectedTab: true,
    //   popActionScreens: PopActionScreensType.all,
    //   itemAnimationProperties: const ItemAnimationProperties(
    //     // Navigation Bar's items animation properties.
    //     duration: Duration(milliseconds: 200),
    //     curve: Curves.ease,
    //   ),
    //   screenTransitionAnimation: const ScreenTransitionAnimation(
    //     // Screen transition animation on change of selected tab.
    //     animateTabTransition: true,
    //     curve: Curves.ease,
    //     duration: Duration(milliseconds: 200),
    //   ),
    //   navBarStyle:
    //       NavBarStyle.style9, // Choose the nav bar style with this property.
    // );
  }

  List<GButton> _navBarsItems(context) {
    return [
      const GButton(
        icon: CupertinoIcons.home,
        text: "الرئيسية",
      ),
      const GButton(
        icon: CupertinoIcons.search,
        text: "بحث",
      ),
      const GButton(
        icon: CupertinoIcons.heart,
        text: "المفضلة",
      ),
      GButton(
        icon: CupertinoIcons.cart,
        text: "${HomeCubit.get(context).cartList.length} العربة",
      ),
      const GButton(
        icon: CupertinoIcons.person,
        text: "حسابي",
      ),
    ];
  }
}
