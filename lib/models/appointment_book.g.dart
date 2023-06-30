// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentBooked _$AppointmentBookedFromJson(Map<String, dynamic> json) =>
    AppointmentBooked(
      date: json['date'] as String?,
      patientID: json['patientID'] as String?,
      timeSlot: json['timeSlot'] as String?,
      doctorId: json['doctorId'] as String?,
      patientName: json['patientName'] as String?,
      contactNo: json['contactNo'] as String?,
    );

Map<String, dynamic> _$AppointmentBookedToJson(AppointmentBooked instance) =>
    <String, dynamic>{
      'date': instance.date,
      'patientID': instance.patientID,
      'patientName': instance.patientName,
      'timeSlot': instance.timeSlot,
      'doctorId': instance.doctorId,
      'contactNo': instance.contactNo,
    };
