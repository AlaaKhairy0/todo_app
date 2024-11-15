import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/colors_manager.dart';

typedef Validator = String? Function(String?);

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hint,
      this.controller,
      this.validator,
      this.keyboard = TextInputType.text,
      this.isHidden = false});

  String hint;
  TextEditingController? controller;
  Validator? validator;
  TextInputType? keyboard;
  bool isHidden;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isHidden,
      keyboardType: keyboard,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsManager.white),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsManager.white),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        fillColor: ColorsManager.white,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        hintText: hint,
        hintStyle: LightAppStyle.authHint,
      ),
    );
  }
}
