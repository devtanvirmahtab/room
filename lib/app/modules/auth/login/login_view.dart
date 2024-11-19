import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_text_style.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_form_field.dart';
import '../../../routes/app_pages.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: mainPadding(20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: text16Style(),
            ),
            gapH12,
            AppFormField(
              controller: controller.emailController,
              hintText: "Enter Email",
            ),
            gapH12,
            AppFormField(
              controller: controller.passwordController,
              hintText: "Enter Password",
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: mainPadding(0, 20),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: () => controller.loginUser(
                  controller.emailController.text,
                  controller.passwordController.text,
                ),
                child: Obx(() {
                  return Center(
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      "Login",
                      style: text16Style(),
                    ),
                  );
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: text14Style(),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.SIGN_UP);
                  },
                  child: Text(
                    "Register",
                    style: text14Style(),
                  ),
                )
              ],
            ),
            gapH16,
            AppButton(
              text: 'Login with google',
              onTap: () async {
                bool res = await controller.authMethod.signInWithGoogle(context);
                if(res){
                  Get.offAndToNamed(Routes.MAIN_NAV);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
