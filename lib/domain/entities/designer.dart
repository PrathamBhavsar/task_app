import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'designer.g.dart';

@JsonSerializable()
class Designer extends Equatable {
  @JsonKey(name: 'designer_id')
  final int? designerId;

  final String name;

  @JsonKey(name: 'firm_name')
  final String firmName;

  @JsonKey(name: 'contact_no')
  final String contactNo;

  final String address;

  @JsonKey(name: 'profile_bg_color')
  final String profileBgColor;

  const Designer({
    required this.name,
    required this.firmName,
    required this.contactNo,
    required this.address,
    required this.profileBgColor,
    this.designerId,
  });

  factory Designer.fromJson(Map<String, dynamic> json) =>
      _$DesignerFromJson(json);

  Map<String, dynamic> toJson() => _$DesignerToJson(this);

  @override
  List<Object?> get props => [
    designerId,
    name,
    firmName,
    contactNo,
    address,
    profileBgColor,
  ];
}
