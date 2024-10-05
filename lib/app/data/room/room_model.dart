class Room {
  String roomId;
  String roomName;
  String createdBy;
  int participants;
  DateTime? createdAt;

  Room({
    required this.roomId,
    required this.roomName,
    required this.createdBy,
    required this.participants,
    this.createdAt,
  });


  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      roomId: map['roomId'],
      roomName: map['roomName'],
      createdBy: map['createdBy'],
      participants: map['participants'],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'roomName': roomName,
      'createdBy': createdBy,
      'participants': participants,
      'createdAt': createdAt != null ? createdAt!.millisecondsSinceEpoch : null,
    };
  }
}
