import 'package:json_annotation/json_annotation.dart';

part 'reports.g.dart';

@JsonSerializable()
class Reports {
  String? id;
  List<String>? reportImages;
  String? typeOfRecord;
  String? issuedBY;
  String? dateOfUpload;

  Reports({
    this.id,
    this.reportImages,
    this.typeOfRecord,
    this.issuedBY,
    this.dateOfUpload,
  });

  factory Reports.fromJson(Map<String, dynamic> json) =>
      _$ReportsFromJson(json);

  Map<String, dynamic> toJson() => _$ReportsToJson(this);
}
