import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/screens/add_product/add_product_screen.dart';
import 'package:grocery_admin_panel/screens/all_products/all_producrs_screen.dart';
import 'package:grocery_admin_panel/widgets/custom_icon_button.dart';
import 'package:iconly/iconly.dart';

class RowButtons extends StatelessWidget {
  const RowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          height: 42,
          text: 'View All',
          backgroundColor: Colors.blue,
          icon: Icons.store,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const AllProducesScreen(),
              ),
            );
          },
        ),
        CustomIconButton(
          text: 'Add New',
          backgroundColor: Colors.blue,
          height: 42,
          icon: IconlyBold.plus,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const AddProductScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
