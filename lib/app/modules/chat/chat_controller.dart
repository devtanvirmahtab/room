import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';

import '../../data/chat/message_model.dart';
import '../../data/user/user_model.dart';
import '../../routes/app_pages.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();
  final messages = <MessageModel>[].obs;
  String senderId = auth.currentUser?.uid ?? '';
  final chatRoomId = "".obs;
  final userId = "".obs;
  final user = UserModel().obs;

  @override
  void onInit() {
    final arguments = Get.arguments;
    if (arguments != null) {
      chatRoomId.value = arguments['chatRoomId'];
      userId.value = arguments['userId'];
      getUserDetails(userId.value);
      listenForMessages();
      listenForIncomingCalls(chatRoomId.value);
    }
    super.onInit();
  }

  void listenForIncomingCalls(String chatRoomIdT) {
    FirebaseFirestore.instance
        .collection('calls')
        .doc(chatRoomIdT)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists &&
          snapshot.data()?['offer'] != null) {
        logger.d("listenForIncomingCalls");
        Get.toNamed(Routes.CALL,arguments: {
          'chatRoomId':chatRoomId.value,
        });
      }
    });
  }

  getUserDetails(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        user.value = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  void listenForMessages() {
    firestore
        .collection('chats')
        .doc(chatRoomId.value)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs
          .map((doc) =>
              MessageModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  void sendMessage(String content, String senderId) async {
    try {
      await firestore
          .collection('chats')
          .doc(chatRoomId.value)
          .collection('messages')
          .add({
        'content': content,
        'senderId': senderId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
