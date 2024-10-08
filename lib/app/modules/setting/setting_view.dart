import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';
import 'package:room/app/core/widgets/app_button.dart';

import '../../routes/app_pages.dart';
import 'setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingView'),
        centerTitle: true,
      ),
      body: Center(
        child: AppButton(
          text: 'Logout',
          onTap: () async {
            await auth.signOut().then((_){
              Get.offAllNamed(Routes.LOGIN);
            });
          },
        ),
      ),
    );
  }
}
