import 'package:flutter/material.dart';

class ImageControllButtons extends StatelessWidget {
  const ImageControllButtons({Key? key, required this.onClearTap})
      : super(key: key);

  final void Function() onClearTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onClearTap,
          child: Text(
            'clear',
            style: const TextStyle().copyWith(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
