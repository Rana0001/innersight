// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      status: json['status'] as String?,
      amount: json['amount'] as String?,
      billDate: json['billDate'] as String?,
      contact: json['contact'] as String?,
      docID: json['docID'] as String?,
      patientId: json['patientId'] as String?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'status': instance.status,
      'amount': instance.amount,
      'billDate': instance.billDate,
      'contact': instance.contact,
      'docID': instance.docID,
      'patientId': instance.patientId,
    };
