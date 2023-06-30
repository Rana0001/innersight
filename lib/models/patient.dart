import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? date;
  String? location;
  String? profileUrl;

  Patient(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.date,
      this.location,
      this.phone,
      this.profileUrl});

  factory Patient.fromJson(Map<String, dynamic>? json) =>
      _$PatientFromJson(json!);
  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
