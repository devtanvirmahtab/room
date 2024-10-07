import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_text_style.dart';
import '../../../routes/app_pages.dart';
import '../../call_check.dart';
import '../../room/room_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: mainPadding(20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: boundButton(
                    title: 'Create Room',
                    onTap: () {
                      Get.to(const RoomView());
                    },
                  ),
                ),
                gapW12,
                Expanded(
                  child: boundButton(
                    title: 'Join Room',
                    onTap: () {
                      Get.to(MyHomePage());
                    },
                  ),
                ),
              ],
            ),
            gapH16,
            Obx(() {
              return Visibility(
                visible: controller.roomList.isNotEmpty,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Rooms List',
                    style: text16Style(),
                  ),
                ),
              );
            }),
            Expanded(
              child: Obx(() {
                if (controller.roomList.isEmpty) {
                  return Center(
                    child: Text(
                      'No rooms available.\n Please Create New Room',
                      style: text16Style(),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.separated(
                  padding: mainPadding(0, 10),
                  itemCount: controller.roomList.length,
                  itemBuilder: (context, index) {
                    final roomId = controller.roomList[index];
                    return listItem(roomId: roomId);
                  },
                  separatorBuilder: (context, index) {
                    return gapH12;
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget boundButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.video_call_rounded,
              color: AppColor.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: text14Style(
                isWhiteColor: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem({required String roomId}) {
    return InkWell(
      onTap: () {
        Get.to(RoomView(roomId: roomId,));
      },
      child: Ink(
        padding: mainPadding(20, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.infoColor.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomId,
                  style: text16Style(),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
