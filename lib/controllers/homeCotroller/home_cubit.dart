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

  void init() async {
    if (userId != '') {
      tabController = PageController();
      emit(ProductsLoading());
      await getAllProducts();
      await getFavProduct();
      await getCartItems();
      await getAdresses();
      await getAlOrders();
      await getSearchList();
      getfavIds();
      tabList = products;
      emit(ProductsLoaded());
    }
  }

  bool addAdressflag = true;
  void toggleAddAdress() {
    addAdressflag = !addAdressflag;
    emit(ToggleAddAdress());
  }

  setAdressTrue() {
    addAdressflag = true;
    emit(ToggleAddAdress());
  }

  int pageIndex = 0;
  void changePageIndex(index) {
    tabController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    emit(BodyChangedState());
  }

  List<Widget> bodyPages = [
    const HomeScreen(),
    SearchScreen(),
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

  Future logOut() async {
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
      t += i.product.price! * i.quantity;
    }
    total = t;

    return t;
  }

  List<Product> products = [];
  Future<void> getAllProducts() async {
    products = await FirestoreServices.getAllProducts();
  }

  List<Product> favProduct = [];
  List<String> favids = [];
  Future<void> getFavProduct() async {
    favProduct = await FirestoreServices.getFav();
  }

  void getfavIds() {
    favids.addAll(favProduct.map((e) => e.id!));
  }

  bool isFav(String id) => favids.contains(id);

  void toggleFav(String id) {
    if (favids.contains(id)) {
      //Product p = products.firstWhere((element) => element.id == id);
      favProduct.removeWhere((element) => element.id == id);
      favids.remove(id);
      emit(ChageCategory());
      FirestoreServices.removeFav(id);
    } else {
      favProduct.add(products.firstWhere((element) => element.id == id));
      favids.add(id);
      emit(ChageCategory());
      FirestoreServices.addFav(id);
    }
  }

  List<Product> tabList = [];
  Map<String, Cart> cartList = {};

  void findCategory(categoryName) {
    if (categoryName == "الكل") {
      tabList = products;
    } else {
      tabList = products
          .where((element) => element.category!.contains(categoryName))
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
      cartList.update(cart.product.id!,
          (value) => Cart(value.product, value.quantity + cart.quantity));

      FirestoreServices.addToCart(
          cart.product.id!, cartList[cart.product.id]!.quantity);

      emit(ChageCategory());
    } else {
      cartList.putIfAbsent(
          cart.product.id!, () => Cart(cart.product, cart.quantity));
      FirestoreServices.addToCart(cart.product.id!, cart.quantity);
      emit(ChageCategory());
    }
  }

  Future<void> getCartItems() async {
    cartList = await FirestoreServices.getCart();
  }

  Future removeCartItem(String productId) async {
    cartList.removeWhere((key, value) => key == productId);
    await FirestoreServices.removeCartItem(productId);
    emit(ChageCategory());
  }

  bool inCart(String product) => cartList.containsKey(product);

  void minusOne() {
    if (quantity <= 1) {
      return;
    }
    quantity -= 1;
    emit(ChageCategory());
  }

  List<AdressModel> adresses = [];

  Future<void> getAdresses() async {
    adresses = await FirestoreServices.getAdresses();
  }

  void addAdress(AdressModel adress, doc) {
    adresses.add(adress);
    FirestoreServices.saveAdress(adress, doc);
    emit(AddAdress());
  }

  void deleteAdress(AdressModel adressModel) {
    adresses.remove(adressModel);
    FirestoreServices.deleteAdress(adressModel.id);
    emit(AddAdress());
  }

  List<OrderModel> orders = [];

  Future<void> getAlOrders() async {
    orders = await FirestoreServices.getAllOrders();
  }

  void addOrder(OrderModel order) async {
    orders.add(order);
    final cartIds = cartList.keys.toList();
    await FirestoreServices.emptyCart(cartIds);
    await FirestoreServices.addToOrders(order);
    initailCart();
    emit(AddAdress());
  }

  Future emptyCart() async {
    final cartIds = cartList.keys.toList();
    await FirestoreServices.emptyCart(cartIds);
    initailCart();
    emit(AddAdress());
  }

  void initailCart() {
    //pageIndex = 0;
    cartList.clear();
    total = 0;
    emit(AddAdress());
  }

  List<Product> searchList = [];
  List<Product> searchItems = [];
  Future getSearchList() async {
    searchList = await FirestoreServices.search();
    searchItems = searchList;
  }

  void search(String? keyWord) {
    if (keyWord == null || keyWord == '') {
      searchItems = searchList;
      emit(SearchComplete());
    } else {
      searchItems = searchList
          .where((element) =>
              element.name!.toLowerCase().contains(keyWord.toLowerCase()) ||
              element.details!.toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
      emit(SearchComplete());
    }
  }
}
