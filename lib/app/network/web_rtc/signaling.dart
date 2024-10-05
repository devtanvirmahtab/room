import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../core/constant/app_constants.dart';

class Signaling {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream; // Local media stream
  final Map<String, dynamic> _configuration = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'}, // STUN server
    ]
  };

  // Create PeerConnection
  Future<void> initializePeerConnection(String roomId, RTCVideoRenderer remoteRenderer) async {
    // Create the RTCPeerConnection
    _peerConnection = await createPeerConnection(_configuration);

    // Handle ICE candidates and send them to Firestore
    _peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      _sendIceCandidate(candidate, roomId); // Send ICE candidate to Firestore
    };

    // Handle connection state changes (optional for debugging)
    _peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      print('Connection state: $state');
    };

    // Handle remote tracks to display the remote video stream
    _peerConnection?.onTrack = (RTCTrackEvent event) {
      if (event.track.kind == 'video' && event.streams.isNotEmpty) {
        // Set the remote stream in the remote video renderer
        remoteRenderer.srcObject = event.streams[0];
      }
    };
  }

  // Get local media stream (audio/video)
  Future<void> getUserMedia(RTCVideoRenderer localRenderer) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      },
    };
    _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    localRenderer.srcObject = _localStream; // Set local stream for video view
    _peerConnection?.addStream(_localStream!); // Add local stream to peer connection
  }

  // Create WebRTC offer
  Future<void> createOffer(String roomId) async {
    RTCSessionDescription offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);

    // Send offer to Firestore
    await firestore.collection('rooms').doc(roomId).set({
      'offer': {
        'type': offer.type,
        'sdp': offer.sdp,
      },
    });
  }

  // Create WebRTC answer
  Future<void> createAnswer(String roomId) async {
    RTCSessionDescription answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    // Send answer to Firestore
    await firestore.collection('rooms').doc(roomId).update({
      'answer': {
        'type': answer.type,
        'sdp': answer.sdp,
      },
    });
  }

  // Listen for incoming offers
  void listenForOffer(String roomId) {
    firestore.collection('rooms').doc(roomId).snapshots().listen((snapshot) async {
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null && data['offer'] != null) {
          RTCSessionDescription offer = RTCSessionDescription(
            data['offer']['sdp'],
            data['offer']['type'],
          );
          await _peerConnection!.setRemoteDescription(offer); // Set remote description
          await createAnswer(roomId); // Create answer
        }
      }
    });
  }

  // Listen for incoming answers
  void listenForAnswer(String roomId) {
    firestore.collection('rooms').doc(roomId).snapshots().listen((snapshot) async {
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null && data['answer'] != null) {
          RTCSessionDescription answer = RTCSessionDescription(
            data['answer']['sdp'],
            data['answer']['type'],
          );
          await _peerConnection!.setRemoteDescription(answer); // Set remote description
        }
      }
    });
  }

  // Send ICE candidates to Firestore
  void _sendIceCandidate(RTCIceCandidate candidate, String roomId) {
    firestore.collection('rooms').doc(roomId).collection('candidates').add({
      'candidate': candidate.candidate,
      'sdpMid': candidate.sdpMid,
      'sdpMLineIndex': candidate.sdpMLineIndex,
    });
  }

  // Listen for ICE candidates from Firestore
  void listenForIceCandidates(String roomId) {
    firestore.collection('rooms').doc(roomId).collection('candidates').snapshots().listen((snapshot) {
      for (var doc in snapshot.docs) {
        var candidate = RTCIceCandidate(
          doc.data()['candidate'],
          doc.data()['sdpMid'],
          doc.data()['sdpMLineIndex'],
        );
        _peerConnection?.addCandidate(candidate); // Add ICE candidate to peer connection
      }
    });
  }

  // Toggle audio mute/unmute
  void toggleAudioMute(bool mute) {
    if (_localStream != null) {
      _localStream!.getAudioTracks().forEach((track) {
        track.enabled = !mute; // Mute/unmute audio track
      });
    }
  }

  // Toggle video mute/unmute
  void toggleVideoMute(bool mute) {
    if (_localStream != null) {
      _localStream!.getVideoTracks().forEach((track) {
        track.enabled = !mute; // Mute/unmute video track
      });
    }
  }

  // Function to update participants in Firestore
  Future<void> updateParticipants(String roomId, Map<String, String> participants) async {
    final roomDoc = firestore.collection('rooms').doc(roomId);

    await roomDoc.update({
      'participants': participants,
    });

    // After updating, check if the current user is the last participant
    final roomSnapshot = await roomDoc.get();
    final roomData = roomSnapshot.data();

    if (roomData != null) {
      final participants = roomData['participants'] as Map<String, dynamic>;
      if (participants.isEmpty) {
        closeWebRTCConnection();
      }
    }

  }

  void closeWebRTCConnection() {
    logger.d('closeWebRTCConnection');
    // Stop all local media tracks
    _localStream?.getTracks().forEach((track) {
      track.stop();
    });

    // Close the peer connection
    _peerConnection?.close();

    // Optionally: Clean up references
    _localStream = null;
    _peerConnection = null;
    logger.d('closeWebRTCConnection Ended');
  }
}
