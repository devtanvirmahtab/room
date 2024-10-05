import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'room_screen_controller.dart';


class RoomScreenView extends GetView<RoomScreenController> {
  const RoomScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RoomScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RoomScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
