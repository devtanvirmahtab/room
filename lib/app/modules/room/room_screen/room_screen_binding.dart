import 'package:get/get.dart';

import 'room_screen_controller.dart';


class RoomScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomScreenController>(
      () => RoomScreenController(),
    );
  }
}
