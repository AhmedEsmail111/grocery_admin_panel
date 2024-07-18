import 'package:flutter/material.dart';

class CustomAlertDialogue extends StatelessWidget {
  const CustomAlertDialogue({
    Key? key,
    required this.title,
    required this.contentText,
    required this.onPressed,
  }) : super(key: key);
  final String title;

  final String contentText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Image.asset(
            'assets/images/warning-sign.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: Text(
        contentText,
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        // TextButton(
        //   onPressed: () {
        //     if (Navigator.canPop(context)) {
        //       Navigator.pop(context);
        //     }
        //   },
        //   child: const Text(
        //     'Cancel',
        //     style: TextStyle(color: Colors.lightBlue),
        //   ),
        // ),
        TextButton(
          onPressed: () {
            onPressed();
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
