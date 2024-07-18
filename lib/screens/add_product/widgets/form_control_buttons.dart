import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/widgets/custom_icon_button.dart';
import 'package:iconly/iconly.dart';

import '../../../services/utils.dart';

class FormControlButtons extends StatelessWidget {
  const FormControlButtons(
      {Key? key, required this.onFormUpload, required this.onFormClear})
      : super(key: key);

  final void Function()? onFormUpload;
  final void Function()? onFormClear;

  @override
  Widget build(BuildContext context) {
    final width = Utils(context).getScreenSize.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.14),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconButton(
            onPressed: onFormClear,
            height: 40,
            icon: IconlyBold.danger,
            backgroundColor: Colors.red,
            text: 'Clear form',
          ),
          const SizedBox(
            width: 40,
          ),
          CustomIconButton(
            onPressed: onFormUpload,
            height: 40,
            width: 125,
            icon: IconlyBold.upload,
            backgroundColor: Colors.blue,
            text: 'Upload',
          )
        ],
      ),
    );
  }
}
