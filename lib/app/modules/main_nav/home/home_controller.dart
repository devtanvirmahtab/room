import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';



class HomeController extends GetxController {

  final roomList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRooms();
  }

  // Fetch rooms from Firestore and update the room list using the Room model
  void fetchRooms() {
    logger.d("fetchRooms");
    firestore.collection('roomsDB').snapshots().listen((snapshot) {
      roomList.clear();
      for (var doc in snapshot.docs) {
        roomList.add(doc.id.toString());
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

}
