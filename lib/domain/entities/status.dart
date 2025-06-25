import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status extends Equatable {
  @JsonKey(name: 'status_id')
  final int? statusId;
  final String name;
  final String slug;
  final String color;

  const Status({
    required this.statusId,
    required this.name,
    required this.slug,
    required this.color,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  List<Object?> get props => [statusId, name, slug, color];

  static List<Status> get list => [
    Status(statusId: 1, name: "Created", slug: "created", color: "#FFD580"),

    Status(
      statusId: 2,
      name: "Agency: Assigned",
      slug: "agency_assigned",
      color: "#A0D8B3",
    ),

    Status(
      statusId: 3,
      name: "Measurement: Received",
      slug: "measurement_received",
      color: "#B0E0E6",
    ),

    Status(
      statusId: 4,
      name: "Measurement: In Progress",
      slug: "measurement_in_progress",
      color: "#F6D6FF",
    ),

    Status(
      statusId: 5,
      name: "Measurement: Done",
      slug: "measurement_done",
      color: "#FFCBCB",
    ),

    Status(
      statusId: 6,
      name: "Quotation: Sent",
      slug: "quotation_sent",
      color: "#FFF5BA",
    ),

    Status(
      statusId: 7,
      name: "Quotation: Approved",
      slug: "quotation_approved",
      color: "#C1E1C1",
    ),

    Status(
      statusId: 8,
      name: "Quotation: Rejected",
      slug: "quotation_rejected",
      color: "#F2B5D4",
    ),

    Status(statusId: 9, name: "Ordered", slug: "ordered", color: "#C6D8FF"),

    Status(
      statusId: 10,
      name: "Invoice: Approved",
      slug: "invoice_approved",
      color: "#D3F8E2",
    ),

    Status(
      statusId: 11,
      name: "Invoice: Rejected",
      slug: "invoice_rejected",
      color: "#FFD6D6",
    ),

    Status(
      statusId: 12,
      name: "Installation: Approved",
      slug: "installation_approved",
      color: "#E6E6FA",
    ),

    Status(
      statusId: 13,
      name: "Bill: Created",
      slug: "bill_created",
      color: "#FEE1E8",
    ),

    Status(
      statusId: 14,
      name: "Bill: Paid",
      slug: "bill_paid",
      color: "#D5E8D4",
    ),

    Status(
      statusId: 15,
      name: "Bill: Unpaid",
      slug: "bill_unpaid",
      color: "#FBE7C6",
    ),
  ];
}
