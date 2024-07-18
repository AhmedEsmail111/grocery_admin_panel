import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../consts/constants.dart';
import '../../../providers/add_product_provider.dart';
import '../../../services/utils.dart';
import '../../../widgets/custom_text_field.dart';
import 'categories_drop_down_button.dart';
import 'measure_units_row.dart';

class ProductInfoColumn extends StatefulWidget {
  const ProductInfoColumn({Key? key}) : super(key: key);

  @override
  State<ProductInfoColumn> createState() => _ProductInfoColumnState();
}

class _ProductInfoColumnState extends State<ProductInfoColumn> {
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    final addProductProvider = Provider.of<AddProductProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' price in \$*',
          style: const TextStyle().copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 110,
          child: CustomTextField(
            controller: addProductProvider.priceController,
            hintText: '',
            textInputType: TextInputType.number,
            autovalidateMode: _autovalidateMode,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9.]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                _autovalidateMode = AutovalidateMode.always;

                return 'please enter a price';
              }
              return null;
            },
            onSaved: (value) {
              final price = double.tryParse(value!);
              if (price != null) {
                context.read<AddProductProvider>().saveProductPrice(price);
              }
            },
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Text(
          'Product Category *',
          style: const TextStyle().copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const CategoriesDropDownButton(),
        const SizedBox(
          height: defaultPadding,
        ),
        Text(
          'Measure unit*',
          style: const TextStyle().copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const MeasureUnitsRow()
      ],
    );
  }
}
