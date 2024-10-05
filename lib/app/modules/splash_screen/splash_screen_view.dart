import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:room/app/core/constant/app_text_style.dart';

import 'splash_screen_controller.dart';


class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          controller.title,
          style: text20Style(
            isPrimaryColor: true,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
