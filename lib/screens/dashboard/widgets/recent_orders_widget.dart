import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/models/order_model.dart';
import 'package:provider/provider.dart';

import '../../../services/utils.dart';
import '../../../widgets/order_item.dart';

class RecentOrdersWidget extends StatelessWidget {
  const RecentOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;

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
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.separated(
                  padding: const EdgeInsets.all(
                    defaultPadding,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length > 5
                      ? 5
                      : snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    final doc = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    final order = OrderModel.fromJson(doc);
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Recent orders',
                          style: const TextStyle().copyWith(
                            color: color,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }
                    return ChangeNotifierProvider.value(
                      value: order,
                      child: const OrderItem(),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    if (index == 0) {
                      return const SizedBox(
                        height: 4,
                      );
                    }
                    return const Divider(
                      thickness: 2,
                    );
                  }),
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
