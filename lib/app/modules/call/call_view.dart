import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';
import 'package:room/app/core/widgets/app_button.dart';

import 'call_controller.dart';

class CallView extends GetView<CallController> {
  const CallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Container(),
        title: const Text('Incoming Call'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display caller's name or ID
            Obx(() {
              return Text(
                controller.callState.value, // Display caller ID
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            gapH12,
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ), // Placeholder for caller's image
            ),
            gapH12,
            AppButton(
              onTap: () {
                controller.receiveCall();
                // Optionally navigate to the call screen if needed
              },
              text: 'Accept',
            ),
            gapH12,
            AppButton(
              onTap: () {
                controller.endCall();
                Get.back(); // Navigate back to the previous screen
              },
              text: 'Decline',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
