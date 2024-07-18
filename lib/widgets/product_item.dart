import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/models/product.dart';
import 'package:grocery_admin_panel/providers/products_provider.dart';
import 'package:grocery_admin_panel/screens/edit_product/edit_prod.dart';
import 'package:grocery_admin_panel/widgets/fancy_shimmer_image.dart';
import 'package:provider/provider.dart';

import '../../../services/utils.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final utils = Utils(context);
    final isDark = utils.getTheme;
    final color = utils.color;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final product = Provider.of<Product>(context);
    // final userPrice = product.isOnSale ? product.salePrice : product.price;
    // print(product.imageUrl);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EditProductScreen(
              product: product,
            ),
          ),
        );
      },
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: FancyImage(
                      isDark: isDark,
                      imageUrl: product.imageUrl,
                      imageHeight: width * 0.12,
                      imageWidth: width * 0.15,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    itemBuilder: (ctx) => [
                      PopupMenuItem(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProductScreen(
                                product: product,
                              ),
                            ),
                          );
                        },
                        child: const Text('Edit'),
                        value: 0,
                      ),
                      PopupMenuItem(
                        onTap: () {
                          productsProvider.deleteProduct(
                            productId: product.id,
                            context: context,
                          );
                        },
                        child: Text(
                          'Delete',
                          style: const TextStyle().copyWith(
                            color: Colors.red,
                          ),
                        ),
                        value: 1,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(children: [
                Text(
                  product.isOnSale
                      ? '\$${product.salePrice.toStringAsFixed(2)}'
                      : '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle().copyWith(
                    color: color,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Visibility(
                  visible: product.isOnSale,
                  child: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle().copyWith(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  product.isPiece ? '1 Piece' : 'kg',
                  style: const TextStyle().copyWith(
                    color: color,
                    fontSize: 16,
                  ),
                )
              ]),
              const SizedBox(
                height: 6,
              ),
              Text(
                product.title,
                style: const TextStyle().copyWith(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
