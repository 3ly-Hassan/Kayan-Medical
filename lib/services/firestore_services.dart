import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kayan/models/adress_model.dart';
import 'package:kayan/models/cart_model.dart';
import 'package:kayan/models/order_model.dart';
import 'package:kayan/models/product_model.dart';
import 'package:kayan/utility/constatns.dart';

import 'fiestore_collection.dart';

class FirestoreServices {
  static Future<void> saveUser(String email, String name, String uId) async {
    await usersCollection.doc(uId).set({
      'email': email,
      'name': name,
      'uid': uId,
    });
  }

  static Future<void> saveAdress(
      AdressModel model, DocumentReference<Map<String, dynamic>> doc) async {
    await doc.set(model.toJson(doc.id));
  }

  static Future<void> deleteAdress(adressId) async {
    await adressCollection
        .doc(userId)
        .collection('MYADRESSES')
        .doc(adressId)
        .delete();
  }

  static Future<List<AdressModel>> getAdresses() async {
    List<AdressModel> adressesList = [];
    QuerySnapshot<Map<String, dynamic>> adresses =
        await adressCollection.doc(userId).collection('MYADRESSES').get();
    for (var adress in adresses.docs) {
      adressesList.add(AdressModel.fromJson(adress.data()));
    }
    return adressesList;
  }

  static Future<void> saveProduct(Product model) async {
    final productId = productsCollection.doc().id;
    await productsCollection.doc(productId).set(model.toJson(productId));
  }

  static Future<List<Product>> getAllProducts() async {
    final p = await productsCollection.orderBy('rate').limit(20).get();
    List<Product> products = [];
    for (var i in p.docs) {
      products.add(Product.fromJson(i.data()));
    }
    return products;
  }

  static Future<void> addFav(String productId) async {
    await usersCollection
        .doc(userId)
        .collection('Fav')
        .doc(productId)
        .set({'id': productId});
  }

  static Future<void> removeFav(String productId) async {
    await usersCollection.doc(userId).collection('Fav').doc(productId).delete();
  }

  static Future<List<Product>> getFav() async {
    List<String> ids = [];
    List<Product> favProducts = [];
    QuerySnapshot<Map<String, dynamic>> favDocs =
        await usersCollection.doc(userId).collection('Fav').get();
    for (var i in favDocs.docs) {
      ids.add(i.id);
    }
    if (ids.isNotEmpty) {
      final p = await productsCollection.where('id', whereIn: ids).get();
      for (var i in p.docs) {
        favProducts.add(Product.fromJson(i.data()));
      }
    }

    return favProducts;
  }

  static Future<void> addToCart(String productId, int quantity) async {
    await usersCollection
        .doc(userId)
        .collection('CART')
        .doc(productId)
        .set({'id': productId, 'quantity': quantity});
  }

  static Future<Map<String, Cart>> getCart() async {
    Map<String, Cart> cart = {};

    final userCart = await usersCollection.doc(userId).collection('CART').get();
    for (var i in userCart.docs) {
      final p = await productsCollection.where('id', isEqualTo: i.id).get();
      for (var x in p.docs) {
        Product product = Product.fromJson(x.data());
        cart.putIfAbsent(i.id, () => Cart.fromJson(i.data(), product));
      }
    }
    return cart;
  }

  static Future<void> emptyCart(List<String> ids) async {
    for (var id in ids) {
      await usersCollection.doc(userId).collection('CART').doc(id).delete();
    }
  }

  static Future<void> removeCartItem(String itemId) async {
    await usersCollection.doc(userId).collection('CART').doc(itemId).delete();
  }

  static Future<void> addToOrders(OrderModel orderModel) async {
    await usersCollection
        .doc(userId)
        .collection('ORDERS')
        .doc(orderModel.id)
        .set(orderModel.toJson());
  }

  static Future<List<OrderModel>> getAllOrders() async {
    List<OrderModel> orders = [];
    final ordersDocs =
        await usersCollection.doc(userId).collection('ORDERS').get();
    for (var i in ordersDocs.docs) {
      final adressdocs = await adressCollection
          .doc(userId)
          .collection('MYADRESSES')
          .where('id', isEqualTo: i.data()['adressId'])
          .get();

      final AdressModel adressModel =
          AdressModel.fromJson(adressdocs.docs.first.data());

      orders.add(OrderModel.fromJson(i.data(), adressModel));
    }
    return orders;
  }

  static Future<List<Product>> search() async {
    final p = await productsCollection.limit(10).get();
    List<Product> products = [];
    for (var i in p.docs) {
      products.add(Product.fromJson(i.data()));
    }
    return products;
  }
}
