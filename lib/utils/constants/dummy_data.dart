abstract class DummyData {
  static const List<Map<String, dynamic>> taskDetailTimeline = [
    {
      'time': "Nov 30, 2023 at 9:15 AM",
      'title': "Task Created",
      'subtitle': "Task was created by John Doe",
    },
    {
      'time': "Nov 30, 2023 at 10:30 AM",
      'title': "Note Added",
      'subtitle': "Customer prefers neutral colors for the blinds",
    },
    {
      'time': "Dec 1, 2023 at 9:00 AM",
      'title': "Samples Sent",
      'subtitle': "Sent fabric samples to customer via mail",
    },
    {
      'time': "Dec 1, 2023 at 2:15 PM",
      'title': "Customer Response",
      'subtitle': "Customer confirmed interest in beige option for living room",
    },
  ];

  static const List<Map<String, dynamic>> adminDashboard = [
    {'title': "Total Tasks", 'data': "127", 'subtitle': "+14% from last month"},
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

  static const List<Map<String, dynamic>> agencyDetailDashboard = [
    {'title': "Total Tasks", 'data': "45"},
    {'title': "Completed", 'data': "23"},
    {'title': "Pending", 'data': "3"},
    {'title': "Rating", 'data': "4.8"},
  ];

  static const List<Map<String, dynamic>> agencyDetailPerformanceMetrics = [
    {'title': "On-time Completion", 'data': 95},
    {'title': "Measurement Accuracy", 'data': 98},
    {'title': "Customer Satisfaction", 'data': 92},
    {'title': "Response Time", 'data': 89},
  ];
}
