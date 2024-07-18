import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/widgets/product_item.dart';

import '../../../services/utils.dart';

class AllProductsGridView extends StatelessWidget {
  const AllProductsGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    // final height = MediaQuery.sizeOf(context).height;
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width < 650 ? 2 : 4,
          childAspectRatio: size.width < 1100 ? 0.9 : 1,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
        ),
        itemBuilder: (ctx, index) => const ProductItem(),
      ),
    );
  }
}
