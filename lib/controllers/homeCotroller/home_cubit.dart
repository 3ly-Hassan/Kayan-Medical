import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayan/controllers/homeCotroller/home_states.dart';
import 'package:kayan/models/adress_model.dart';
import 'package:kayan/models/order_model.dart';
import 'package:kayan/screens/home/navigationScreens/cart_screen/cart_screen.dart';
import 'package:kayan/screens/home/navigationScreens/favourite/favourite_screen.dart';
import 'package:kayan/screens/home/navigationScreens/home_screen/home_screen.dart';
import 'package:kayan/screens/home/navigationScreens/profile_screen/profile_screen.dart';
import 'package:kayan/services/firestore_services.dart';
import 'package:kayan/utility/constatns.dart';

import '../../models/cart_model.dart';
import '../../models/product_model.dart';
import '../../screens/home/navigationScreens/search/search_screen.dart';
import '../../services/firabase_auth_service.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  late PageController tabController;
  void init() {
    tabController = PageController();
    getFavProduct();
    tabList = products;
  }

  int pageIndex = 0;
  void changePageIndex(index) {
    tabController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    emit(BodyChangedState());
  }

  List<Widget> bodyPages = [
    const HomeScreen(),
    const SearchScreen(),
    const FavScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void bodyChange(index) {
    pageIndex = index;
    emit(BodyChangedState());
  }

  int tabIndex = 0;
  void tabChange(index) {
    tabIndex = index;
    emit(TabChangedState());
  }

  void logOut() async {
    emit(LogoutLoadding());
    try {
      await AuthServices.logOut();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError(error: 'حدث خطأ اثناء تسجيل الخروج'));
    }
  }

  double total = 0.0;
  double totalAmount(List<Cart> products) {
    double t = 0;
    for (var i in products) {
      t += i.product.price * i.quantity;
    }
    total = t;

    return t;
  }

  List<Product> products = [
    Product(
        id: 1,
        category: 'اجهزة قياس سكر',
        name: 'بيرفكتا نيرو',
        details:
            "جهاز قياس السكر بيرفيكتا نيرو شاشة مضيئة لسهولة القراءة الجهاز يعمل بالبطاريات العادية خاصية طارد الشريط مؤشر صائم و فاطر سهل الإستخدام",
        imgUrl: "assets/images/Perfecta-Nero-2-550x550.png",
        price: 250,
        company: 'جرانزيا',
        rate: 3,
        fav: true),
    Product(
        id: 2,
        category: 'اجهزة مساج',
        name: 'جهاز مساج Relaxtra',
        details:
            "يساعد علي تخسيس مناطق الجسم المختلفة يمكنك التحكم في مستويات المساج ديجيتال سهولة تغيير مستوي المساج رؤوس متعددة لوظائف مختلفة إخراج الرطوبة والبرودة من الجسم وتنشيط الدورة الدموية جميع منتجات جرانزيا الإيطالية ضمان حقيقي لمدة عامين",
        imgUrl: "assets/images/relaxtra.png",
        price: 750,
        company: 'جرانزيا',
        rate: 4,
        fav: true),
    Product(
        id: 3,
        category: 'اجهزة ضغط',
        name: 'جهاز ضغط استرو',
        details:
            "جهاز قياس السكر بيرفيكتا نيرو شاشة مضيئة لسهولة القراءة الجهاز يعمل بالبطاريات العادية خاصية طارد الشريط مؤشر صائم و فاطر سهل الإستخدام",
        imgUrl: "assets/images/astro.png",
        price: 500,
        company: 'جرانزيا',
        rate: 3.7),
    Product(
        id: 4,
        category: 'اجهزة قياس سكر',
        name: 'بيرفكتا بيانكا',
        details:
            "جهاز قياس السكر بيرفيكتا نيرو شاشة مضيئة لسهولة القراءة الجهاز يعمل بالبطاريات العادية خاصية طارد الشريط مؤشر صائم و فاطر سهل الإستخدام",
        imgUrl: "assets/images/bianca.png",
        price: 150,
        company: 'جرانزيا',
        rate: 3.1,
        fav: true),
    Product(
        id: 5,
        category: 'اخري',
        name: 'شفاط ثدي ديجتال GentleFeed',
        details:
            "جهاز قياس السكر بيرفيكتا نيرو شاشة مضيئة لسهولة القراءة الجهاز يعمل بالبطاريات العادية خاصية طارد الشريط مؤشر صائم و فاطر سهل الإستخدام",
        imgUrl: "assets/images/gentleFeed.png",
        price: 2600,
        company: 'جرانزيا',
        rate: 4.7),
    Product(
        id: 6,
        category: 'اجهزة ضغط',
        name: 'جهاز ضغط هوائي palmotnes-L',
        details:
            "جهاز قياس السكر بيرفيكتا نيرو شاشة مضيئة لسهولة القراءة الجهاز يعمل بالبطاريات العادية خاصية طارد الشريط مؤشر صائم و فاطر سهل الإستخدام",
        imgUrl: "assets/images/palmotnes.png",
        price: 260,
        company: 'جرانزيا',
        rate: 3.8,
        fav: true),
    Product(
        id: 7,
        category: 'اخري',
        name: 'ميزان مطبخ ',
        details:
            "جهاز قياس السكر بيرفيكتا نيرو شاشة مضيئة لسهولة القراءة الجهاز يعمل بالبطاريات العادية خاصية طارد الشريط مؤشر صائم و فاطر سهل الإستخدام",
        imgUrl: "assets/images/v-cooka.png",
        price: 285,
        company: 'جرانزيا',
        rate: 3.2,
        fav: true),
    Product(
        id: 8,
        category: 'اجهزة استنشاق',
        name: 'بيرفكتا نيرو',
        details:
            "جهاز قياس السكر بيرفيكتا نيرو شاشة مضيئة لسهولة القراءة الجهاز يعمل بالبطاريات العادية خاصية طارد الشريط مؤشر صائم و فاطر سهل الإستخدام",
        imgUrl: "assets/images/pure.png",
        price: 710,
        company: 'جرانزيا',
        rate: 3.9),
    Product(
        id: 9,
        category: 'اجهزة ضغط',
        name: 'بيرفكتا نيرو',
        details:
            "جهاز قياس السكر بيرفيكتا نيرو شاشة مضيئة لسهولة القراءة الجهاز يعمل بالبطاريات العادية خاصية طارد الشريط مؤشر صائم و فاطر سهل الإستخدام",
        imgUrl: "assets/images/smarta.png",
        price: 830,
        company: 'جرانزيا',
        rate: 3.9,
        fav: true),
  ];

  List<Product> favProduct = [];
  void getFavProduct() =>
      favProduct = products.where((element) => element.fav).toList();

  bool isFav(product) => favProduct.contains(product);

  void toggleFav(Product product) {
    if (favProduct.contains(product)) {
      favProduct.remove(product);
      emit(ChageCategory());
    } else {
      favProduct.add(product);
      emit(ChageCategory());
    }
  }

  List<Product> tabList = [];
  Map<int, Cart> cartList = {};

  void findCategory(categoryName) {
    if (categoryName == "الكل") {
      tabList = products;
    } else {
      tabList = products
          .where((element) => element.category.contains(categoryName))
          .toList();
    }
    emit(ChageCategory());
  }

  @override
  Future<void> close() {
    tabController.dispose();
    return super.close();
  }

  int quantity = 1;
  void addOne() {
    quantity += 1;
    emit(ChageCategory());
  }

  void makeQuantityOne() {
    quantity = 1;
    emit(ChageCategory());
  }

  void addToCart(Cart cart) {
    if (cartList.containsKey(cart.product.id)) {
      cartList.update(cart.product.id,
          (value) => Cart(value.product, value.quantity + cart.quantity));
      emit(ChageCategory());
    } else {
      cartList.putIfAbsent(
          cart.product.id, () => Cart(cart.product, cart.quantity));
      emit(ChageCategory());
    }
  }

  bool inCart(int product) => cartList.containsKey(product);

  void minusOne() {
    if (quantity <= 1) {
      return;
    }
    quantity -= 1;
    emit(ChageCategory());
  }

  List<AdressModel> adresses = [];

  void addAdress(AdressModel adress) {
    adresses.add(adress);
    FirestoreServices.saveAdress(adress, userId);
    emit(AddAdress());
  }

  List<OrderModel> orders = [];

  void addOrder(OrderModel order) {
    orders.add(order);
    emit(AddAdress());
  }

  void initailCart() {
    //pageIndex = 0;
    cartList.clear();
    total = 0;
    emit(AddAdress());
  }
}