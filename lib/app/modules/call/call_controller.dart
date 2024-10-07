import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

import '../../network/web_rtc/signaling.dart';


enum CallState { idle, calling, receiving, connected }

class CallController extends GetxController {
  final roomController = TextEditingController();
  Signaling signaling = Signaling();
  final localRenderer = RTCVideoRenderer().obs;
  final remoteRenderer = RTCVideoRenderer().obs;
  final roomId = ''.obs;
  final textEditingController = TextEditingController(text: '');

  @override
  void onInit() {
    final arguments = Get.arguments;
    if(arguments != null){
      localRenderer.value.initialize();
      remoteRenderer.value.initialize();

      signaling.onAddRemoteStream = ((stream) {
        remoteRenderer.value.srcObject = stream;
      });

      signaling.openUserMedia(localRenderer.value, remoteRenderer.value);
    }
    super.onInit();
  }

  @override
  void onClose() {
      localRenderer.value.dispose();
      remoteRenderer.value.dispose();
    super.onClose();
  }

}
