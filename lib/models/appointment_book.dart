import 'package:json_annotation/json_annotation.dart';

part 'appointment_book.g.dart';

@JsonSerializable()
class AppointmentBooked {
  String? date;
  String? patientID;
  String? patientName;
  String? timeSlot;
  String? doctorId;
  String? contactNo;

  AppointmentBooked({
    this.date,
    this.patientID,
    this.timeSlot,
    this.doctorId,
    this.patientName,
    this.contactNo
  });

  factory AppointmentBooked.fromJson(Map<String, dynamic> json) =>
      _$AppointmentBookedFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentBookedToJson(this);
}
