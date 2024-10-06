import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:room/app/core/constant/app_constants.dart';

import '../../../network/web_rtc/signaling.dart';

class RoomScreenController extends GetxController {
  final id = ''.obs;
  final signaling = Signaling();
  final localRenderer = RTCVideoRenderer().obs;
  final remoteRenderer = RTCVideoRenderer().obs;
  var participants = <String, String>{}.obs;
  final audioMuted = false.obs, videoMuted = false.obs;
  final isAudioMuted = false.obs;
  final isVideoMuted = false.obs;

  @override
  void onInit() {
    final arguments = Get.arguments;
    if (arguments != null) {
      if (arguments['id'] != null) {
        id.value = arguments['id'];
        logger. d('arguments ${id.value}');
        // joinRoom(id.value);
        initialize(id.value);
      }
    }

    super.onInit();
  }

  Future<void> joinRoom(String roomId) async {
    await localRenderer.value.initialize();
    await remoteRenderer.value.initialize();

    final roomDoc = firestore.collection('rooms').doc(roomId);

    // Check if the room exists
    final roomSnapshot = await roomDoc.get();
    if (!roomSnapshot.exists) {
      Get.back();
      appWidget.showSimpleToast("Room doesn't exist");
      return;
    }

    // Get room data
    var roomData = roomSnapshot.data();
    if (roomData != null) {
      // Initialize WebRTC signaling


      // Get user media
      await signaling.getUserMedia(localRenderer.value);

      // Add the user to the participants map
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        participants[user.uid] = user.displayName ?? 'Unknown';
        await roomDoc.update({
          'participants': participants,
        });
      }

      // await signaling.initializePeerConnection(roomId, remoteRenderer);
      // Listen for incoming offers and answers
      // signaling.listenForOffer(roomId);
      // signaling.listenForAnswer(roomId);
      // signaling.listenForIceCandidates(roomId);

    //   // Create an offer if this user is the first participant
    //   if (roomData['participants'].length == 1) {
    //     await signaling.createOffer(roomId);
    //   } else {
    //     // If not the first participant, wait for an offer from the room
    //     logger.d('Waiting for offer...');
    //   }
    //   // Optionally, update UI to show the user has joined the room
    //   logger.d('User joined the room');
    // } else {
    //   logger.d('Failed to retrieve room data');
    }
    // Listen for participant updates
    // listenForParticipants(roomId);
  }

  Future<void> initialize(roomId) async {
    await localRenderer.value.initialize();
    await remoteRenderer.value.initialize();
    await signaling.getUserMedia(localRenderer.value);

    // Get user UID and display name
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      String displayName = user.displayName ?? 'User'; // Fallback if no display name
      participants[uid] = displayName; // Add user to participants
      await signaling.updateParticipants(roomId, participants); // Update Firestore
    }

    // Initialize PeerConnection and listeners
    await signaling.initializePeerConnection(roomId, remoteRenderer.value);
    signaling.listenForOffer(roomId);
    signaling.listenForAnswer(roomId);
    signaling.listenForIceCandidates(roomId);

    // Listen for participant updates
    listenForParticipants(roomId);
  }

// Listen for participant updates
  void listenForParticipants(String roomId) {
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null && data['participants'] != null) {
          participants.value = Map<String, String>.from(
              data['participants']); // Update the participants map
        }
      }
    });
  }

  // // Fetch rooms from Firestore
  // void fetchRooms() {
  //   firestore.collection('rooms').snapshots().listen((snapshot) {
  //     roomList.clear();
  //     for (var doc in snapshot.docs) {
  //       roomList.add(Room.fromMap(doc.data() as Map<String, dynamic>));
  //     }
  //   });
  // }

  // Function to start a call
  Future<void> startCall() async {
    await signaling.getUserMedia(localRenderer.value); // Get local audio/video stream
    await signaling.createOffer(id.value); // Create WebRTC offer
  }

  void toggleAudio() {
    audioMuted.value = !audioMuted.value;
    signaling.toggleAudioMute(audioMuted.value);
  }

  void toggleVideo() {
    videoMuted.value = !videoMuted.value;
    signaling.toggleVideoMute(videoMuted.value);
  }

  // Fetch the user’s name from Firestore
  Future<String?> getUserNameById(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      return userDoc['displayName'] ?? 'Unknown User';
    }
    return 'Unknown User';
  }

  Future<void> close() async {
    await localRenderer.value.dispose();
    await remoteRenderer.value.dispose();

    // Remove user from participants list
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      participants.remove(user.uid);
      await signaling.updateParticipants(id.value, participants);
    }
  }

  @override
  void onClose() {
    close();
    super.onClose();
  }
}
