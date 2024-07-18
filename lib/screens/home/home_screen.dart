import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/controllers/menu_controller.dart';
import 'package:grocery_admin_panel/providers/products_provider.dart';
import 'package:grocery_admin_panel/widgets/loading_manager.dart';
import 'package:grocery_admin_panel/widgets/side_menu.dart';
import 'package:provider/provider.dart';

import '../../responsive.dart';
import '../dashboard/dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      key: context.read<MenuControllerr>().getScaffoldKey,
      drawer: const SideMenu(),
      body: CustomLoadingManager(
        isLoading: productsProvider.isLoading,
        child: SafeArea(
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
              const Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: DashboardScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
