import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = FirebaseFirestore.instance;
final usersCollection = fireStore.collection('USERS');
final productsCollection = fireStore.collection('PRODUCTS');
final favCollection = fireStore.collection('FAVS');
final adressCollection = fireStore.collection('ADRESSES');
final ordersCollection = fireStore.collection('ORDERS');
final cartCollection = fireStore.collection('CARTS');
