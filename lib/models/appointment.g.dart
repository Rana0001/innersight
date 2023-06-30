// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      date: json['date'] as String?,
      timeSlot: (json['timeSlot'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      doctorId: json['doctorId'] as String?,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'date': instance.date,
      'timeSlot': instance.timeSlot,
      'doctorId': instance.doctorId,
    };
