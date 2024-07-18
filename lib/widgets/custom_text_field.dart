import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    // required this.isObscured,
    this.textInputAction,
    this.focusNode,
    required this.textInputType,
    this.validator,
    this.onSaved,
    this.onEditingComplete,
    this.autovalidateMode,
    // required this.hidePassword,
    // this.onVisibilityTaped,
    this.maxLines = 1,
    this.inputFormatters,
    this.controller,
  }) : super(key: key);
  final String hintText;
  // final bool isObscured;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  // final bool hidePassword;
  // final void Function()? onVisibilityTaped;
  final int maxLines;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      focusNode: focusNode,
      validator: validator,
      onSaved: onSaved,
      maxLines: maxLines,
      // obscureText: hidePassword,
      onEditingComplete: onEditingComplete,
      style: const TextStyle().copyWith(color: color, fontSize: 18),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: color)),
        hintText: hintText,
        hintStyle: const TextStyle().copyWith(
          color: color,
          fontSize: 18,
        ),
        // suffixIcon: isObscured
        //     ? IconButton(
        //         onPressed: onVisibilityTaped,
        //         icon: hidePassword
        //             ? const Icon(
        //                 Icons.visibility,
        //                 color: Colors.white,
        //               )
        //             : const Icon(
        //                 Icons.visibility_off,
        //                 color: Colors.white,
        //               ),
        //       )
        //     : null,
      ),
      cursorColor: Colors.blue,
    );
  }
}
