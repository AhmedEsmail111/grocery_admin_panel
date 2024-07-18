import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/screens/dashboard/widgets/products_grid_view.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:provider/provider.dart';

import '../../controllers/menu_controller.dart';
import '../../responsive.dart';
import '../../widgets/side_menu.dart';

class AllProducesScreen extends StatelessWidget {
  const AllProducesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuControllerr>().getgridScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),

            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Header(
                          title: 'All Products',
                          fct: () {
                            context
                                .read<MenuControllerr>()
                                .controlProductsMenu();
                          }),
                    ),
                    const SizedBox(height: defaultPadding),
                    const ProductsGridView(
                      isInMain: false,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
