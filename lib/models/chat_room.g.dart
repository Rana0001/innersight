// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      patientMsg: json['patientMsg'] as bool? ?? false,
      messages: json['messages'] as String? ?? "",
      dateTimeText: json['dateTimeText'] as String? ?? "",
    )
      ..patientId = json['patientId'] as String? ?? ""
      ..doctorId = json['doctorId'] as String? ?? "";

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'patientMsg': instance.patientMsg ?? false,
      'messages': instance.messages ?? "",
      'dateTimeText': instance.dateTimeText ?? "",
      'patientId': instance.patientId ?? "",
      'doctorId': instance.doctorId ?? "",
    };
