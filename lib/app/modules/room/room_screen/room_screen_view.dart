import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:get/get.dart';

import 'room_screen_controller.dart';


class RoomScreenView extends GetView<RoomScreenController> {
  const RoomScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text("Room: ");
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_end),
            onPressed: () async {

              Get.back(); // Navigate back
            },
          ),
        ],
      ),
      body: Column(
        children: [
        ],
      ),
    );
  }
}

