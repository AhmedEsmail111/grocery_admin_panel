import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/models/product.dart';
import 'package:grocery_admin_panel/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../../../services/utils.dart';
import '../../../widgets/product_item.dart';

class ProductsGridView extends StatelessWidget {
  final bool isInMain;
  const ProductsGridView({Key? key, this.isInMain = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final size = Utils(context).getScreenSize;
    final height = MediaQuery.sizeOf(context).height;
    final color = Utils(context).color;
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection(productsCollection).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data!.docs.isNotEmpty) {
            return GridView.builder(
              itemCount: isInMain
                  ? snapshot.data!.docs.length <= 4
                      ? snapshot.data!.docs.length
                      : 4
                  : snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width < 650 ? 2 : 4,
                childAspectRatio: size.width < 1100 ? 0.9 : 1,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
              ),
              itemBuilder: (ctx, index) {
                final product = Product(
                  id: snapshot.data!.docs[index]['id'],
                  title: snapshot.data!.docs[index]['title'],
                  productCategory: snapshot.data!.docs[index]
                      ['productCategory'],
                  imageUrl: snapshot.data!.docs[index]['imageUrl'],
                  price: snapshot.data!.docs[index]['price'],
                  salePrice: snapshot.data!.docs[index]['salePrice'],
                  isOnSale: snapshot.data!.docs[index]['isOnSale'],
                  isPiece: snapshot.data!.docs[index]['isPiece'],
                  createdAt: snapshot.data!.docs[index]['createdAt'],
                );

                return ChangeNotifierProvider.value(
                  value: product,
                  child: const ProductItem(),
                );
              },
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Text(
                  'There are no products in your store yet!',
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

        if (snapshot.hasError) {
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

        return Container();
      },
    );
  }
}
