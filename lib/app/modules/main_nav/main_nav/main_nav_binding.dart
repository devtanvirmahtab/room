import 'package:get/get.dart';

import '../chat_list/chat_list_controller.dart';
import '../home/home_controller.dart';
import 'main_nav_controller.dart';


class MainNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavController>(
      () => MainNavController(),
    );


    Get.lazyPut<HomeController>(
          () => HomeController(),
    );

    Get.lazyPut<ChatListController>(
          () => ChatListController(),
    );

  }
}
