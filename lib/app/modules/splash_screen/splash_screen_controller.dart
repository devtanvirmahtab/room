import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/app_constants.dart';
import '../../routes/app_pages.dart';

class SplashScreenController extends GetxController {

  final title = 'Room';

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1),() {
        checkUserAuthStatus();
      },);
    });
    super.onInit();
  }

  // Function to check if the user is signed in or not
  void checkUserAuthStatus() async {
    User? user = auth.currentUser;
    if (user != null) {
      Get.offAndToNamed(Routes.MAIN_NAV);
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

}
