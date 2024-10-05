import 'package:get/get.dart';

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
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
