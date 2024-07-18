import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/providers/orders_provider.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:provider/provider.dart';

import '../../../consts/constants.dart';
import '../../../models/order_model.dart';
import '../../../widgets/order_item.dart';

class AllOrdersListView extends StatelessWidget {
  const AllOrdersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    final orders = Provider.of<OrdersProvider>(context).orders;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(ordersCollection)
          .get()
          .asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('error');
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Text(
                'An error happened while fetching your store',
                style: const TextStyle().copyWith(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print('active');
          if (snapshot.data!.docs.isNotEmpty) {
            return Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) {
                  final doc =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  final order = OrderModel.fromJson(doc);

                  return ChangeNotifierProvider.value(
                    value: order,
                    child: const OrderItem(),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    thickness: 2,
                  );
                },
              ),
            );
          } else {
            print('empty');
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Text(
                  'There are no Orders made yet!',
                  style: const TextStyle().copyWith(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }
        }
        print('nothing ');
        return Container();
      },
    );
  }
}
