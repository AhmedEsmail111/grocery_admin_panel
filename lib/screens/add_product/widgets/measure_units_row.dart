import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/providers/add_product_provider.dart';
import 'package:provider/provider.dart';

import '../../../services/utils.dart';

class MeasureUnitsRow extends StatefulWidget {
  const MeasureUnitsRow({Key? key}) : super(key: key);

  @override
  State<MeasureUnitsRow> createState() => _MeasureUnitsRowState();
}

class _MeasureUnitsRowState extends State<MeasureUnitsRow> {
  @override
  Widget build(BuildContext context) {
    final addProductProvider = Provider.of<AddProductProvider>(context);
    final color = Utils(context).color;
    return Row(
      children: [
        Text(
          'kg',
          style: const TextStyle().copyWith(color: color),
        ),
        Radio(
          activeColor: Colors.green,
          value: 1,
          groupValue: addProductProvider.groupValue,
          onChanged: (value) {
            addProductProvider.changeGroupValue(1);
            addProductProvider.changeIsPiece(false);
          },
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'piece',
          style: const TextStyle().copyWith(color: color),
        ),
        Radio(
          activeColor: Colors.green,
          value: 2,
          groupValue: addProductProvider.groupValue,
          onChanged: (value) {
            addProductProvider.changeGroupValue(2);
            addProductProvider.changeIsPiece(true);
          },
        ),
      ],
    );
  }
}
