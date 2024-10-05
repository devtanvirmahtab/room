import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';
import 'package:room/app/core/widgets/app_button.dart';

import 'create_room_controller.dart';

class CreateRoomView extends GetView<CreateRoomController> {
  const CreateRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateRoomView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: mainPadding(20, 20),
        child: Column(
          children: [
            TextField(
              controller: controller.roomNameController,
              decoration: const InputDecoration(
                labelText: 'Room Name',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder()
              ),
            ),
            gapH20,
            AppButton(
              text: 'Create Room',
              onTap: () {
                controller.createRoomHandler();
              },
            )
          ],
        ),
      ),
    );
  }
}
