import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room/app/core/constant/app_colors.dart';
import 'package:room/app/core/constant/app_constants.dart';
import 'package:room/app/core/constant/app_text_style.dart';

import '../../routes/app_pages.dart';
import 'chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
            controller.user.value.name ?? '',
            style: text16Style(
              isWhiteColor: true,
            ),
          );
        }),
        backgroundColor: AppColor.primaryColor,
        actions: [
          IconButton(onPressed: (){
            Get.toNamed(Routes.CALL,);
          }, icon: const Icon(Icons.call),)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return Column(
                    crossAxisAlignment: message.senderId == controller.senderId
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: mainPadding(20, 10),
                        margin: mainPadding(20, 5),
                        width: Get.width * 0.6,
                        decoration: BoxDecoration(
                            color: AppColor.likeWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          message.content,
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (controller.messageController.text.trim().isNotEmpty) {
                      controller.sendMessage(
                        controller.messageController.text.trim(),
                        controller.senderId, // Replace with actual sender's UID
                      );
                      controller.messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
