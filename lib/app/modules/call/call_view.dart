import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';
import 'package:room/app/core/widgets/app_button.dart';

import 'call_controller.dart';

class CallView extends GetView<CallController> {
  const CallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Column(
              children: [
                gapH30,
                Wrap(
                  children: [
                    AppButton(
                      onTap: () {
                        controller.signaling.openUserMedia(
                          controller.localRenderer.value,
                          controller.remoteRenderer.value,
                        );
                        logger.d("Open camera");
                      },
                      text: "Open camera & microphone",
                    ),
                    gapW8,
                    AppButton(
                      onTap: () async {
                        controller.roomId.value = await controller.signaling
                            .createRoom(controller.remoteRenderer.value);
                        controller.textEditingController.text =
                            controller.roomId.value;
                        logger.d('roomId ${controller.roomId.value}');
                      },
                      text: 'Call',
                    ),
                    gapW8,
                    AppButton(
                      onTap: () {
                        // Add roomId
                        controller.signaling.joinRoom(
                          controller.textEditingController.text.trim(),
                          controller.remoteRenderer.value,
                        );
                      },
                      text: "Join room",
                    ),
                    gapW8,
                    AppButton(
                      onTap: () {
                        controller.signaling
                            .hangUp(controller.localRenderer.value);
                      },
                      text: "Hangup",
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: controller.roomController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder()),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Obx(() {
                    return RTCVideoView(controller.localRenderer.value,
                        mirror: true);
                  }),
                ),
                Expanded(
                  child: Obx(() {
                    return RTCVideoView(controller.remoteRenderer.value);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
