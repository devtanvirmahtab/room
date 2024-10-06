import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';

import '../../../data/user/user_model.dart';

class ChatListController extends GetxController {
  var usersList = <UserModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('users').get();
      var usersData = snapshot.docs.map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
      usersList.value = usersData;
    }on FirebaseException catch (e) {
      logger.d('Error fetching users: $e');
    }
  }



  String getChatRoomId(String userId1, String userId2) {
    return userId1.compareTo(userId2) > 0 ? "$userId2$userId1" : "$userId1$userId2";
  }

  @override
  void onClose() {
    super.onClose();
  }

}
