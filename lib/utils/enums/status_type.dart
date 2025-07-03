import '../../domain/entities/status.dart';

enum StatusType {
  created,
  agencyAssigned,
  measurementReceived,
  measurementInProgress,
  measurementDone,
  quotationSent,
  quotationInProgress,
  quotationApproved,
  quotationRejected,
  ordered,
  invoiceApproved,
  invoiceRejected,
  installationApproved,
  billCreated,
  billPaid,
  billUnpaid,
}

extension StatusTypeX on StatusType {
  Status get status {
    switch (this) {
      case StatusType.created:
        return Status(
          statusId: 1,
          name: "Created",
          slug: "created",
          color: "#FFD580",
        );
      case StatusType.agencyAssigned:
        return Status(
          statusId: 2,
          name: "Agency: Assigned",
          slug: "agency_assigned",
          color: "#A0D8B3",
        );
      case StatusType.measurementReceived:
        return Status(
          statusId: 3,
          name: "Measurement: Received",
          slug: "measurement_received",
          color: "#B0E0E6",
        );
      case StatusType.measurementInProgress:
        return Status(
          statusId: 4,
          name: "Measurement: In Progress",
          slug: "measurement_in_progress",
          color: "#F6D6FF",
        );
      case StatusType.measurementDone:
        return Status(
          statusId: 5,
          name: "Measurement: Done",
          slug: "measurement_done",
          color: "#FFCBCB",
        );
      case StatusType.quotationSent:
        return Status(
          statusId: 6,
          name: "Quotation: Sent",
          slug: "quotation_sent",
          color: "#FFF5BA",
        );
      case StatusType.quotationInProgress:
        return Status(
          statusId: 7,
          name: "Quotation: In Progress",
          slug: "quotation_in_progress",
          color: "#FFF5CA",
        );
      case StatusType.quotationApproved:
        return Status(
          statusId: 8,
          name: "Quotation: Approved",
          slug: "quotation_approved",
          color: "#C1E1C1",
        );
      case StatusType.quotationRejected:
        return Status(
          statusId: 9,
          name: "Quotation: Rejected",
          slug: "quotation_rejected",
          color: "#F2B5D4",
        );
      case StatusType.ordered:
        return Status(
          statusId: 10,
          name: "Ordered",
          slug: "ordered",
          color: "#C6D8FF",
        );
      case StatusType.invoiceApproved:
        return Status(
          statusId: 11,
          name: "Invoice: Approved",
          slug: "invoice_approved",
          color: "#D3F8E2",
        );
      case StatusType.invoiceRejected:
        return Status(
          statusId: 12,
          name: "Invoice: Rejected",
          slug: "invoice_rejected",
          color: "#FFD6D6",
        );
      case StatusType.installationApproved:
        return Status(
          statusId: 13,
          name: "Installation: Approved",
          slug: "installation_approved",
          color: "#E6E6FA",
        );
      case StatusType.billCreated:
        return Status(
          statusId: 14,
          name: "Bill: Created",
          slug: "bill_created",
          color: "#FEE1E8",
        );
      case StatusType.billPaid:
        return Status(
          statusId: 15,
          name: "Bill: Paid",
          slug: "bill_paid",
          color: "#D5E8D4",
        );
      case StatusType.billUnpaid:
        return Status(
          statusId: 16,
          name: "Bill: Unpaid",
          slug: "bill_unpaid",
          color: "#FBE7C6",
        );
    }
  }

  static Status fromString(String statusString) {
    return StatusType.values
        .firstWhere(
          (e) => e.status.name.toLowerCase() == statusString.toLowerCase(),
      orElse: () => throw ArgumentError('Unknown status: $statusString'),
    )
        .status;
  }
}

