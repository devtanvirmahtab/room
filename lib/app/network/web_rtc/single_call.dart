import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;

class WebRTCController {
  rtc.RTCPeerConnection? peerConnection;
  rtc.MediaStream? localStream;
  rtc.MediaStream? remoteStream;

  Future<rtc.RTCPeerConnection> createPeerConnection() async {
    final config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        // Optionally add TURN server configurations here
      ],
    };
    peerConnection = await rtc.createPeerConnection(config);
    return peerConnection!;
  }

  Future<rtc.MediaStream> getUserMedia() async {
    try {
      final rtc.MediaStream stream =
          await rtc.navigator.mediaDevices.getUserMedia({
        'audio': true,
        'video': false,
        // 'video': {
        //   'facingMode': 'user',
        //   // Use 'user' for front camera, 'environment' for rear camera
        // },
      });
      localStream = stream;
      return stream;
    } catch (e) {
      print('Error getting user media: $e');
      rethrow; // Rethrow the error to handle it where this function is called
    }
  }

  void dispose() {
    localStream?.dispose();
    remoteStream?.dispose();
    peerConnection?.close();
  }
}
