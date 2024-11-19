import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';
import 'package:room/app/modules/sign_up/sign_up_controller.dart';

import '../../core/constant/app_colors.dart';
import '../../core/constant/app_text_style.dart';
import '../../core/widgets/app_form_field.dart';
import '../../routes/app_pages.dart';


class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up',style: text16Style(),),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: mainPadding(20, 20),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign Up",
                    style: text16Style(),
                  ),
                  gapH12,
                  AppFormField(
                    controller: controller.userNameController,
                    hintText: "Enter Name",
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
                      onTap: () {
                        controller.registerUser(
                          controller.userNameController.text,
                          controller.emailController.text,
                          controller.passwordController.text,
                        );
                      },
                      child: Center(
                        child: Obx(() {
                          return controller.isLoading.value
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            "Register",
                            style: text16Style(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  gapH12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: text14Style(
                          color: Colors.grey,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        child: Text(
                          "Login",
                          style: text14Style(),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
