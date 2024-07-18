import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/screens/dashboard/widgets/recent_orders_widget.dart';
import 'package:grocery_admin_panel/screens/dashboard/widgets/row_buttons.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:provider/provider.dart';

import '../../../services/utils.dart';
import '../../controllers/menu_controller.dart';
import 'widgets/products_grid_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              title: 'Dashboard',
              fct: () {
                context.read<MenuControllerr>().controlDashboarkMenu();
              },
            ),
            const SizedBox(height: defaultPadding),
            Text(
              'Latest Products',
              style: const TextStyle().copyWith(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const RowButtons(),
            const SizedBox(
              height: defaultPadding,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // flex: 5,
                  child: Column(
                    children: [
                      ProductsGridView(),

                      SizedBox(
                        height: defaultPadding,
                      ),

                      RecentOrdersWidget()
                      // MyProductsHome(),
                      // SizedBox(height: defaultPadding),
                      // OrdersScreen(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
