import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/models/order_model.dart';
import 'package:grocery_admin_panel/widgets/fancy_shimmer_image.dart';
import 'package:provider/provider.dart';

import '../../../services/utils.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Utils(context).getTheme;
    final color = Utils(context).color;
    final width = Utils(context).getScreenSize.width;
    final order = Provider.of<OrderModel>(context);

    return Row(
      children: [
        Flexible(
          flex: 2,
          child: FancyImage(
            isDark: isDark,
            imageUrl: order.products.first.imageUrl,
            imageHeight: width * 0.13,
            imageWidth: width * 0.13,
          ),
        ),
        const SizedBox(
          width: defaultPadding,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Wrap(
                  children: List.generate(
                    order.products.length,
                    (index) {
                      return Text(
                        '${order.products[index].title} x${order.quantities[index]} ',
                        style: const TextStyle().copyWith(
                          fontSize: 18,
                          color: color,
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  'For \$${order.totalPrice}',
                  style: const TextStyle().copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            RichText(
              text: TextSpan(
                text: 'By  ',
                style: const TextStyle().copyWith(
                  color: Colors.blue,
                ),
                children: [
                  TextSpan(
                    text: order.userName,
                    style: const TextStyle().copyWith(
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${order.orderDate.toDate().day}/${order.orderDate.toDate().month}/${order.orderDate.toDate().year}',
              style: const TextStyle().copyWith(
                fontSize: 14,
                color: color,
              ),
            )
          ],
        ),
      ],
    );
  }
}
