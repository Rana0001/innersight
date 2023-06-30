import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  String? status;
  String? amount;
  String? billDate;
  String? contact;
  String? docID;
  String? patientId;
  Payment({this.status, this.amount, this.billDate, this.contact,this.docID,this.patientId});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
