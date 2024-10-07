import 'package:get/get.dart';

class RoomScreenController extends GetxController {
  @override
  void onInit() {
    final arguments = Get.arguments;
    if (arguments != null) {
      if (arguments['id'] != null) {}
    }

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
