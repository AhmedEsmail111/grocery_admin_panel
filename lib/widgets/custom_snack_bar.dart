import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/responsive.dart';

import '../../../services/utils.dart';

SnackBar buildCustomSnackBar({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
  required IconData icon,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding
}) {
  final width = Utils(context).getScreenSize.width;
  return SnackBar(
    margin: Responsive.isDesktop(context) || width > 600
        ? EdgeInsets.symmetric(horizontal: width * 0.3, vertical: width * 0.05)
        : margin,
    padding: padding,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    content: Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor, // Customize the background color
    behavior: context.mounted
        ? SnackBarBehavior.floating
        : SnackBarBehavior.fixed, // Make it float above other widgets
    duration: const Duration(seconds: 3), // Show for 3 seconds
  );
}
