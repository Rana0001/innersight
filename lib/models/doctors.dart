import 'package:json_annotation/json_annotation.dart';

part 'doctors.g.dart';

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
  String? price;
  String? hospital;

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
    this.price,
    this.hospital
    
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
