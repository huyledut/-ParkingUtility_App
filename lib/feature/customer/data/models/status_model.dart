import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.camel, ignoreNullMembers: true, name: "list")
class StatusModel {
  DateTime? dateOfCheckIn;
  int? vehicalId;
  int? staffId;
  String? vehicalLicensePlate;
  String? vehicalDescription;
  int? customerId;
  String? customerName;
  String? staffName;

  StatusModel({
    this.dateOfCheckIn,
    this.vehicalId,
    this.vehicalLicensePlate,
    this.vehicalDescription,
    this.customerId,
    this.customerName,
  });

  Map<String, dynamic> toJson() {
    return {
      '"dateOfCheckIn"': '"${dateOfCheckIn ?? DateTime(2022)}"',
      '"vehicalId"': vehicalId,
      '"vehicalLicensePlate"': '"${vehicalLicensePlate ?? ""}"',
      '"vehicalDescription"': '"${vehicalDescription ?? ""}"',
      '"customerId"': customerId,
      '"customerName"': '"${customerName ?? ""}"',
    };
  }

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      dateOfCheckIn: DateTime.parse(json['dateOfCheckIn']),
      vehicalId: json['vehicalId'],
      vehicalLicensePlate: json['vehicalLicensePlate'],
      vehicalDescription: json['vehicalDescription'],
      customerId: json['customerId'],
      customerName: json['customerName'],
    );
  }
}
