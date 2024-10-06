import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

import '../../network/web_rtc/single_call.dart';

enum CallState { idle, calling, receiving, connected }

class CallController extends GetxController {
  final callId = ''.obs;
  final senderId = ''.obs;
  var callState = 'idle'.obs;
  final WebRTCController _webrtcController = WebRTCController();

  @override
  void onInit() {
    final arguments = Get.arguments;
    if(arguments != null){
      callId.value = arguments['chatRoomId'];
      senderId.value = arguments['senderId'];
      if(arguments['senderId'] != null){
        makeCall(callId.value,senderId.value);
      }

    }
    super.onInit();
  }


  void makeCall(String chatRoomId, String callerUID) async {
    try {
      // Update the call state to indicate that the call is being initiated
      callState.value = 'calling';

      // Create the call document in Firestore
      await FirebaseFirestore.instance.collection('calls').doc(chatRoomId).set({
        'callerId': callerUID, // Use the actual caller UID
        'offer': null,
        'answer': null,
        'candidate': null,
      });

      // Create the peer connection
      await _webrtcController.createPeerConnection();

      // Get the local media stream (audio and video)
      var localStream = await _webrtcController.getUserMedia();
      _webrtcController.peerConnection!.addStream(localStream);

      // Create an offer and set it as the local description
      var offer = await _webrtcController.peerConnection!.createOffer();
      await _webrtcController.peerConnection!.setLocalDescription(offer);

      // Update the Firestore document with the offer details
      await FirebaseFirestore.instance.collection('calls').doc(chatRoomId).update({
        'offer': {
          'type': offer.type,
          'sdp': offer.sdp,
        },
      });

      // Listen for ICE candidates and update Firestore accordingly
      _webrtcController.peerConnection!.onIceCandidate = (candidate) {
        if (candidate != null) { // Check for null candidate
          FirebaseFirestore.instance.collection('calls').doc(chatRoomId).update({
            'candidate': {
              'candidate': candidate.candidate,
              'sdpMid': candidate.sdpMid,
              'sdpMLineIndex': candidate.sdpMLineIndex,
            },
          });
        }
      };

      // Update the call state to indicate that the call is in progress
      callState.value = 'waiting';
    } catch (e) {
      // Handle errors appropriately
      print("Error making call: $e");
      callState.value = 'error'; // Update call state to error if something goes wrong
    }
  }


  Future<void> receiveCall() async {
    callState.value = 'receiving';

    DocumentSnapshot offerSnapshot = await FirebaseFirestore.instance.collection('calls').doc(callId.value).get();
    if (offerSnapshot.exists) {
      Map<String, dynamic>? data = offerSnapshot.data() as Map<String, dynamic>?;
      if (data != null && data['offer'] != null) {
        await _webrtcController.createPeerConnection();
        var localStream = await _webrtcController.getUserMedia();
        _webrtcController.peerConnection!.addStream(localStream);

        var offer = RTCSessionDescription(data['offer']['sdp'], data['offer']['type']);
        await _webrtcController.peerConnection!.setRemoteDescription(offer);

        var answer = await _webrtcController.peerConnection!.createAnswer();
        await _webrtcController.peerConnection!.setLocalDescription(answer);

        await FirebaseFirestore.instance.collection('calls').doc(data['callerId']).update({
          'answer': {'type': answer.type, 'sdp': answer.sdp},
        });

        _webrtcController.peerConnection!.onAddStream = (stream) {
          _webrtcController.remoteStream = stream;
          callState.value = 'connected';
        };
      } else {
        print("Offer not found in the document.");
      }
    } else {
      print("Call document does not exist.");
    }
  }

  void endCall() {
    callState.value = 'idle';
    _webrtcController.dispose();
  }
}
