import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/app_constants.dart';
import '../../core/utils/fcm_helper.dart';
import '../../routes/app_pages.dart';

class SplashScreenController extends GetxController {

  final title = 'Room';

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FCMHelper().localNotificationListener();
      FCMHelper().initLocalNotification();

      FirebaseMessaging.instance.getToken().then((deviceToken) {
        logger.i("deviceToken: $deviceToken");
        logger.d("deviceToken: $deviceToken");
      });

      Future.delayed(const Duration(seconds: 1),() {
        checkUserAuthStatus();
      },);

      Future.delayed(
        const Duration(milliseconds: 3000),
            () {
          requestNotificationPermission();
        },
      );

    });
    super.onInit();
  }


  requestNotificationPermission() async {
    logger.d("requestNotificationPermission");
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }



  // Function to check if the user is signed in or not
  void checkUserAuthStatus() async {
    User? user = auth.currentUser;
    if (user != null) {
      Get.offAndToNamed(Routes.MAIN_NAV);
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

}
