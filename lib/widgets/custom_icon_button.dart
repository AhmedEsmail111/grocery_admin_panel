import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/consts/constants.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key,
      required this.height,
      this.width,
      required this.icon,
      this.onPressed,
      required this.backgroundColor,
      required this.text})
      : super(key: key);
  final double height;
  final double? width;
  final IconData icon;
  final Color backgroundColor;
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton.icon(
        label: Text(
          text,
          style: const TextStyle().copyWith(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: 4),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
