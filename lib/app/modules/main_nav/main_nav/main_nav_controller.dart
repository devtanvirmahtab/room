import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../chat_list/chat_list_view.dart';
import '../home/home_view.dart';

class MainNavController extends GetxController {
  final  selectedIndex = 0.obs;
  final pages = const [
    HomeView(),
    ChatListView(),
    HomeView(),
  ];

  @override
  void onInit() {
    checkAndRequestPermissions();
    super.onInit();
  }

  Future<void> checkAndRequestPermissions() async {
    // Check camera permission
    PermissionStatus cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      cameraStatus = await Permission.camera.request();
    }

    // Check microphone permission
    PermissionStatus microphoneStatus = await Permission.microphone.status;
    if (!microphoneStatus.isGranted) {
      microphoneStatus = await Permission.microphone.request();
    }

    // Check if both permissions are granted
    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      print("Camera and Microphone permissions are granted.");
      // Proceed with WebRTC initialization or any other logic
    } else {
      print("Permissions are not granted.");
      // Handle the case when permissions are not granted (e.g., show a dialog)
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

}
