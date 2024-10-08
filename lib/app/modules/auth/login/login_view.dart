import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_button.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
