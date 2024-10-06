import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';

import '../../../data/room/room_model.dart';
import '../../../network/web_rtc/signaling.dart';


class HomeController extends GetxController {

  final roomList = <Room>[].obs;

  @override
  void onInit() {
    Signaling().closeWebRTCConnection();
    super.onInit();
    fetchRooms();
  }

  // Fetch rooms from Firestore and update the room list using the Room model
  void fetchRooms() {
    logger.d("fetchRooms");
    firestore.collection('rooms').snapshots().listen((snapshot) {
      roomList.clear();
      for (var doc in snapshot.docs) {
        roomList.add(Room.fromMap(doc.data()));
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

}
