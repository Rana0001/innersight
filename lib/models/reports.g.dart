// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reports _$ReportsFromJson(Map<String, dynamic> json) => Reports(
      id: json['id'] as String?,
      reportImages: (json['reportImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      typeOfRecord: json['typeOfRecord'] as String?,
      issuedBY: json['issuedBY'] as String?,
      dateOfUpload: json['dateOfUpload'] as String?,
    );

Map<String, dynamic> _$ReportsToJson(Reports instance) => <String, dynamic>{
      'id': instance.id,
      'reportImages': instance.reportImages,
      'typeOfRecord': instance.typeOfRecord,
      'issuedBY': instance.issuedBY,
      'dateOfUpload': instance.dateOfUpload,
    };
