import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/app_constants.dart';
import '../../data/user/user_model.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  //register the user
  Future<void> registerUser(
    String username,
    String email,
    String password,
  ) async {
    try {
      isLoading.value = true;
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        //save your to fireStore
        UserCredential credential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        UserModel user = UserModel(
          name: username,
          email: email,
          uid: credential.user!.uid,
        );
        await fireStore
            .collection("users")
            .doc(credential.user!.uid)
            .set(user.toJson()).then((result){
              Get.back();
              Get.snackbar("Success", "Account created Successfully ");
        });
      } else {
        Get.snackbar("Error", "Please Enter All The Field");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error Creating Account", e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
