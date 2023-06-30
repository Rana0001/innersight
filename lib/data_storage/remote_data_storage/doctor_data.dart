import 'package:json_annotation/json_annotation.dart';

part 'doctor_data.g.dart';

@JsonSerializable()
class Doctor {
  String? fullName;
  String? email;
  String? phone;
  String? profileURl;
  String? uid;
  String? speciality;
  String? experience;
  String? qualification;
  String? certificate;
  String? rate;

  Doctor({
    this.fullName,
    this.email,
    this.phone,
    this.profileURl,
    this.uid,
    this.speciality,
    this.experience,
    this.qualification,
    this.certificate,
    this.rate,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
