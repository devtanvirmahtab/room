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
          return Text("Room: ${controller.id.value}");
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_end),
            onPressed: () async {
              await controller.close();
              Get.back(); // Navigate back
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: RTCVideoView(controller.remoteRenderer),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 120,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: RTCVideoView(controller.localRenderer),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => Container(
            padding: EdgeInsets.all(10),
            height: 100, // Fixed height for the participants list
            child: ListView.builder(
              itemCount: controller.participants.length,
              itemBuilder: (context, index) {
                String uid = controller.participants.keys.elementAt(index);
                String name = controller.participants[uid] ?? 'Unknown';
                return ListTile(
                  title: Text(name), // Show participant name
                  subtitle: Text(uid), // Show participant UID (optional)
                );
              },
            ),
          )),
          ControlPanel(roomController: controller),
        ],
      ),
    );
  }
}

class ControlPanel extends StatelessWidget {
  final RoomScreenController roomController;

  const ControlPanel({super.key, required this.roomController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(() => IconButton(
            icon: Icon(
              roomController.audioMuted.value ? Icons.mic_off : Icons.mic,
              color: roomController.audioMuted.value ? Colors.red : Colors.green,
            ),
            onPressed: roomController.toggleAudio,
          )),
          Obx(() => IconButton(
            icon: Icon(
              roomController.videoMuted.value ? Icons.videocam_off : Icons.videocam,
              color: roomController.videoMuted.value ? Colors.red : Colors.green,
            ),
            onPressed: roomController.toggleVideo,
          )),
        ],
      ),
    );
  }
}
