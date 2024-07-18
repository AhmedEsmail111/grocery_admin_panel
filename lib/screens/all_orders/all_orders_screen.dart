import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';
import 'package:grocery_admin_panel/controllers/menu_controller.dart';
import 'package:grocery_admin_panel/responsive.dart';
import 'package:grocery_admin_panel/screens/all_orders/widgets/all_orders_list_view.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:grocery_admin_panel/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuControllerr>().getOrdersScaffoldKey,
      drawer: const SideMenu(),
      body: Row(
        children: [
          if (Responsive.isDesktop(context)) const SideMenu(),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: defaultPadding,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                  ),
                  child: Header(
                    fct: () {
                      context.read<MenuControllerr>().controlAllOrdersMenu();
                    },
                    title: 'All Orders',
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                const AllOrdersListView(),
                const SizedBox(
                  height: defaultPadding,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
