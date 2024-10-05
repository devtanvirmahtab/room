
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_constants.dart';
import '../../../data/room/room_model.dart';
import '../../../routes/app_pages.dart';

class CreateRoomController extends GetxController {
  final roomNameController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
  }

  // Function to create a new room
  Future<void> createRoomHandler() async {
    final roomId = await createRoom();
    if(roomId != null){
      Get.offAndToNamed(Routes.ROOM_SCREEN);
    }else{
      logger.d('Something went wrong');
    }

  }

  Future<String?> createRoom() async {
    final user = auth.currentUser;

    if(roomNameController.text.trim().isNotEmpty){
      if (user != null) {
        var roomId = firestore.collection('rooms').doc().id;
        var room = Room(
          roomId: roomId,
          roomName: roomNameController.text,
          createdBy: user.uid,
          participants: 1,  // Creator is the first participant
          createdAt: DateTime.now(),
        );

        await firestore.collection('rooms').doc(roomId).set(room.toMap());
        return roomId;
      }
    }
    return null;
  }



  @override
  void onClose() {
    roomNameController.dispose();
    super.onClose();
  }

}
