import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room/app/network/auth_methods.dart';

import '../../../core/constant/app_constants.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final authMethod = AuthMethods();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        logger.w("login success");
        Get.offAllNamed(Routes.MAIN_NAV);
      } else {
        Get.snackbar("Error", "Please Enter all fields");
      }
      isLoading.value = false;
    } on FirebaseException catch (e) {
      isLoading.value = false;
      logger.w("login Error ${e.toString()}");
      Get.snackbar("Error", e.toString());
    }
  }


  @override
  void onClose() {
    super.onClose();
  }

}
