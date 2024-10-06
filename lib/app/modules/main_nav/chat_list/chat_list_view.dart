import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room/app/data/user/user_model.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_constants.dart';
import '../../../core/constant/app_text_style.dart';
import '../../../routes/app_pages.dart';
import 'chat_list_controller.dart';

class ChatListView extends GetView<ChatListController> {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: mainPadding(20, 0),
        child: Expanded(
          child: Obx(() {
            if (controller.usersList.isEmpty) {
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
              itemCount: controller.usersList.length,
              itemBuilder: (context, index) {
                final user = controller.usersList[index];
                return listItem(user: user);
              },
              separatorBuilder: (context, index) {
                return gapH12;
              },
            );
          }),
        ),
      ),
    );
  }

  Widget listItem({required UserModel user}) {
    return InkWell(
      onTap: () {
        String currentUserId = auth.currentUser?.uid ??
            ''; // Replace with actual current user's UID
        String otherUserId =
            user.uid ?? ''; // Replace with the selected user's UID
        String chatRoomId =
            controller.getChatRoomId(currentUserId, otherUserId);

        Get.toNamed(Routes.CHAT, arguments: {
          'chatRoomId': chatRoomId,
          'userId': otherUserId,
        });
      },
      child: Ink(
        padding: mainPadding(20, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.liteGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name ?? '',
              style: text16Style(),
              overflow: TextOverflow.ellipsis,
            ),
            gapW8,
            Text(
              user.uid ?? '',
              style: text14Style(),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
