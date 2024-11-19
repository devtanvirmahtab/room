import 'package:flutter/material.dart';

import '../constant/app_colors.dart';


class AppFormField extends StatelessWidget {
  const AppFormField({super.key, this.hintText, required this.controller});

  final String? hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.only(
        //     // left: 0,
        //     // right: 16,
        //     // top: topBottomPadding,
        //     // bottom: topBottomPadding,
        //     ),
        hintText: hintText,
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.disableColor,
            ),
            borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.borderGrayColor,
            ),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.borderGrayColor,
            ),
            borderRadius: BorderRadius.circular(12)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.red,
            ),
            borderRadius: BorderRadius.circular(12)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.red),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}