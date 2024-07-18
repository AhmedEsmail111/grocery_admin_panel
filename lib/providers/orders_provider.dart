import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart' as consonants;

import '../models/order_model.dart';

class OrdersProvider with ChangeNotifier {
  final _fireStore = FirebaseFirestore.instance;
  List<OrderModel> orders = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchOrders() async {
    final users = await _fireStore.collection(consonants.usersCollection).get();
    if (users.docs.isEmpty) {
      orders.clear();
      return;
    }
    try {
      for (final user in users.docs) {
        final querySnapshot = await _fireStore
            .collection(consonants.usersOrdersCollection)
            .doc(user.id)
            .collection(consonants.ordersCollection)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          orders.clear();
          notifyListeners();
          for (final order in querySnapshot.docs) {
            orders.add(
              OrderModel.fromJson({
                'userName': user['name'],
                'data': order.data(),
              }),
            );
          }
        }
      }
      notifyListeners();
      print('got orders successfully');
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
