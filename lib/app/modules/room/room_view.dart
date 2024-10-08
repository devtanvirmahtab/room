import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:room/app/core/constant/app_constants.dart';
import 'package:room/app/core/constant/app_text_style.dart';
import 'package:room/app/core/widgets/app_button.dart';

import '../../network/web_rtc/signaling.dart';

class RoomView extends StatefulWidget {
  final String? roomId;

  const RoomView({
    super.key,
    this.roomId,
  });

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<RoomView> {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? createdRoomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
    init();
    super.initState();
  }

  init() async {
    await signaling.openUserMedia(_localRenderer, _remoteRenderer);

    Future.delayed(const Duration(seconds: 1), () async {
      if (widget.roomId != null) {
        await signaling.joinRoom(
          widget.roomId!,
          _remoteRenderer,
        );
      } else {
        createdRoomId = await signaling.createRoom(_remoteRenderer);
        setState(() {});
      }
    });
  }

  Future<void> deleteRoomIfExists(String roomId) async {
    final docRef = firestore.collection('roomsDB').doc(roomId);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      await docRef.delete();
      logger.d('Room with ID $roomId deleted successfully.');
    } else {
      logger.d('Room with ID $roomId does not exist.');
    }
  }

  @override
  void dispose() {
    if(widget.roomId != null){
      deleteRoomIfExists(widget.roomId ?? '');
    }
    if(createdRoomId != null){
      deleteRoomIfExists(createdRoomId ?? '');
    }

    logger.d("dispose dispose");
    signaling.hangUp(_localRenderer);
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WebRTC Video Call",
          style: text16Style(),
        ),
      ),
      body: Expanded(
        child: Stack(
          fit: StackFit.expand,
          children: [
            RTCVideoView(
              _remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
            Positioned(
              height: 200,
              width: 120,
              top: 20,
              right: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Expanded(
                  child: RTCVideoView(
                    _localRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ),
            ),
            Positioned(
              height: 50,
              bottom: 20,
              right: 20,
              left: 20,
              child: AppButton(
                onTap: () {
                  signaling.hangUp(_localRenderer);
                  Get.back();
                },
                text: "Call End",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
