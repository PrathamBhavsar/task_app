
import '../../data/models/employee.dart';
import '../../data/models/product.dart';
import '../../data/models/services.dart';

abstract class DummyData {
  static const List<String> reportDateRanges = [
    "Today",
    "Yesterday",
    "Last 7 Days",
    "Last 14 Days",
    "Last 30 Days",
    "Last 60 Days",
    "Custom Range",
  ];

  static const List<Map<String, dynamic>> todayAppointments = [
    {'name': "John Doe", 'time': "10:30 AM", 'services': 'Haircut, Styling'},
    {
      'name': "Jane Smith",
      'time': "11:00 AM",
      'services': 'Manicure, Pedicure',
    },
    {
      'name': "Alex Johnson",
      'time': "1:15 PM",
      'services': 'Beard Trim, Shave',
    },
    {
      'name': "Emily Davis",
      'time': "2:45 PM",
      'services': 'Facial, Hair Coloring',
    },
    {
      'name': "Michael Brown",
      'time': "4:00 PM",
      'services': 'Massage, Haircut',
    },
  ];

  static const List<Map<String, dynamic>> managerDashboard = [
    {
      'title': "Revenue",
      'data': "\$1,231.90",
      'subtitle': "+10.1% from yesterday",
    },
    {
      'title': "Appointments",
      'data': "24",
      'subtitle': "8 completed, 16 remaining",
    },
    {'title': "Services", 'data': "12", 'subtitle': "+3 from yesterday"},
    {'title': "Product Sales", 'data': "28", 'subtitle': "+8 from yesterday"},
  ];

  static const List<Map<String, dynamic>> adminDashboard = [
    {
      'title': "Total Tasks",
      'data': "127",
      'subtitle': "+14% from last month",
    },
    {
      'title': "Active Orders",
      'data': "42",
      'subtitle': "+10% from last month",
    },
    {
      'title': "Pending Quotes",
      'data': "23",
      'subtitle': "+5% from last month",
    },
    {
      'title': "Completed Sales",
      'data': "₹45k",
      'subtitle': "+18% from last month",
    },
  ];

  static List<String> getDropdownItems(String title) {
    switch (title) {
      case "Services":
        return Service.names;
      case "Assign Employee":
        return Employee.names;
      case "Add Products":
        return Product.names;
      default:
        return [];
    }
  }

  static const List<Map<String, dynamic>> newAppointmentDetails = [
    {'title': "Phone Number", 'hint': "Enter phone number"},
    {'title': "Full Name", 'hint': "Enter name"},
    {'title': "Email", 'hint': "Enter email"},
    {'title': "Gender", 'hint': ""},
    {'title': "Number of Persons", 'hint': "Enter no. of persons"},
  ];

  static const List<String> newAppointmentSummaryTitles = [
    "Customer",
    "Phone",
    "Persons",
    "Token Number",
    "Date",
  ];

  static const List<Map<String, dynamic>> newSupervisorDetails = [
    {'title': "Full Name", 'hint': "Enter supervisor name"},
    {'title': "Username", 'hint': "Enter username"},
    {'title': "PIN", 'hint': "Enter 4 digit PIN"},
    {'title': "Confirm PIN", 'hint': "Confirm PIN"},
    {'title': "Assign Salons", 'hint': ""},
  ];

  static const List<Map<String, dynamic>> newManagerDetails = [
    {'title': "Full Name", 'hint': "Enter manager name"},
    {'title': "Username", 'hint': "Enter username"},
    {'title': "PIN", 'hint': "Enter 4 digit PIN"},
    {'title': "Confirm PIN", 'hint': "Confirm PIN"},
    {'title': "Assign Salon", 'hint': "Select a salon"},
  ];

  static const List<String> branches = [
    "Elite Cuts",
    "Classic Styles",
    "Glamour Salon",
    "Luxury Nails",
    "Beard Masters",
    "Shave & Trim",
    "Glow Spa",
    "Color Magic",
    "Relax & Refresh",
    "Prime Cuts",
  ];
}
