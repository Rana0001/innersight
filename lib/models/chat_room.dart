import 'package:json_annotation/json_annotation.dart';

part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  bool? patientMsg;
  String? messages;
  String? dateTimeText;
  String? patientId;
  String? doctorId;
  ChatRoom({
    this.patientMsg,
    this.messages,
    this.dateTimeText,
  });
  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
