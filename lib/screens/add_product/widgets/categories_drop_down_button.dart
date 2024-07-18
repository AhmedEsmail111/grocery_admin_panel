import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/providers/add_product_provider.dart';
import 'package:provider/provider.dart';

import '../../../services/utils.dart';

class CategoriesDropDownButton extends StatefulWidget {
  const CategoriesDropDownButton({Key? key}) : super(key: key);

  @override
  State<CategoriesDropDownButton> createState() =>
      _CategoriesDropDownButtonState();
}

class _CategoriesDropDownButtonState extends State<CategoriesDropDownButton> {
  final categories = const [
    'Vegetables',
    'Fruits',
    'Flesh',
    'Grains',
    'Nuts',
    'Herbs',
    'Spices',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Utils(context).getTheme;
    final addProductProvider = Provider.of<AddProductProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          value: addProductProvider.productCategory,
          iconEnabledColor: Colors.black,
          items: List.generate(
            categories.length,
            (index) => DropdownMenuItem<String>(
              value: categories[index],
              child: RichText(
                text: TextSpan(
                  text: categories[index],
                  style: const TextStyle().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
          onChanged: (category) {
            if (category != null) {
              addProductProvider.saveProductCategory(category);
            }
          },
        ),
      ),
    );
  }
}
