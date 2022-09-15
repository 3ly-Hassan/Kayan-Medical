import 'package:kayan/models/adress_model.dart';
import 'package:kayan/models/product_model.dart';

import 'fiestore_collection.dart';

class FirestoreServices {
  static Future<void> saveUser(String email, String name, String uId) async {
    await usersCollection.doc(uId).set({
      'email': email,
      'name': name,
      'uid': uId,
    });
  }

  static Future<void> saveAdress(AdressModel model, String uId) async {
    await adressCollection
        .doc(uId)
        .collection('MYADRESSES')
        .doc()
        .set(model.toJson());
  }

  static Future<void> saveProduct(Product model) async {
    final productId = productsCollection.doc().id;
    await productsCollection.doc(productId).set(model.toJson(productId));
  }
}
