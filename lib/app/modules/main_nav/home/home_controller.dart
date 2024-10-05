import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/room/room_model.dart';


class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final roomList = <Room>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRooms();
  }

  // Fetch rooms from Firestore and update the room list using the Room model
  void fetchRooms() {
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
