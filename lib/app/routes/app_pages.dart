import 'package:get/get.dart';

import '../modules/auth/login/login_binding.dart';
import '../modules/auth/login/login_view.dart';
import '../modules/main_nav/chat_list/chat_list_binding.dart';
import '../modules/main_nav/chat_list/chat_list_view.dart';
import '../modules/main_nav/home/home_binding.dart';
import '../modules/main_nav/home/home_view.dart';
import '../modules/main_nav/main_nav/main_nav_binding.dart';
import '../modules/main_nav/main_nav/main_nav_view.dart';
import '../modules/room/create_room/create_room_binding.dart';
import '../modules/room/create_room/create_room_view.dart';
import '../modules/room/room_screen/room_screen_binding.dart';
import '../modules/room/room_screen/room_screen_view.dart';
import '../modules/splash_screen/splash_screen_binding.dart';
import '../modules/splash_screen/splash_screen_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_NAV,
      page: () => const MainNavView(),
      binding: MainNavBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_LIST,
      page: () => const ChatListView(),
      binding: ChatListBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ROOM,
      page: () => const CreateRoomView(),
      binding: CreateRoomBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_SCREEN,
      page: () => const RoomScreenView(),
      binding: RoomScreenBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
  ];
}
