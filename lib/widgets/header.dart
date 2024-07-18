import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';

import '../../../services/utils.dart';
import '../responsive.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.fct,
    required this.title,
    this.withSearch = true,
  }) : super(key: key);

  final Function fct;
  final String title;
  final bool withSearch;
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = Utils(context).color;

    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(
              Icons.menu,
              color: color,
            ),
            onPressed: () {
              fct();
            },
          ),
        if (Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: color,
                  ),
            ),
          ),
        if (Responsive.isDesktop(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        if (withSearch)
          Expanded(
            child: TextField(
              style: const TextStyle().copyWith(color: color),
              decoration: InputDecoration(
                hintText: "Search",
                fillColor: Theme.of(context).cardColor,
                filled: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                suffixIcon: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding * 0.75),
                    margin: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Icon(
                      Icons.search,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
