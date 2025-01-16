class DummyData {
  static final Map<String, dynamic> dummyTaskData = {
    "name": "test",
    "status": "Quotation: Created",
    "deal_no": "25-0019",
    "remarks": "test",
    "due_date": "2025-01-09T13:47:15.811486+00:00",
    "priority": "High",
    "created_at": "2025-01-07T08:26:55.63643+00:00",
    "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
    "start_date": "2025-01-07T13:47:15.812646+00:00",
    "task_clients": [
      {
        "id": "47bdb46f-8067-4ab1-8f89-1a188a24fe35",
        "name": "client 1",
        "address": "test aaddress",
        "task_id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
        "contact_no": "8490055445",
        "created_at": "2025-01-01T07:26:40.084195+00:00"
      }
    ],
    "task_agencies": [
      {
        "id": "f7c84cb0-f16e-4e6c-8f76-dd629007fb78",
        "name": "Jatin Tailor",
        "role": "Agency",
        "email": "d@gmail.com",
        "task_id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
        "created_at": "2025-01-02T07:58:17.127613+00:00",
        "profile_bg_color": "ff5cd669"
      }
    ],
    "task_designers": [
      {
        "id": "7da4e0ff-f6fc-4220-a135-84866574decb",
        "code": 321,
        "name": "designer 1",
        "address": "address 1",
        "task_id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
        "firm_name": "yaay designers",
        "contact_no": "848954523",
        "created_at": "2025-01-03T12:01:17.930424+00:00",
        "profile_bg_color": "ff5cd669"
      }
    ],
    "task_attachments": [null],
    "task_salespersons": [
      {
        "id": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "name": "Bhushan",
        "role": "Salesperson",
        "email": "a@gmail.com",
        "task_id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
        "created_at": "2025-01-02T07:35:50.240763+00:00",
        "profile_bg_color": "ff9d9bff"
      }
    ]
  };

  static final Map<String, dynamic> dummyFetchedData = {
    "task_priority": [
      {
        "created_at": "2025-01-02T07:32:12.682827+00:00",
        "name": "High",
        "color": "fff6bb54"
      },
      {
        "created_at": "2025-01-02T07:31:37.526168+00:00",
        "name": "Low",
        "color": "ff5cd669"
      },
      {
        "created_at": "2025-01-02T07:31:54.219178+00:00",
        "name": "Medium",
        "color": "ff9d9bff"
      }
    ],
    "clients": [
      {
        "id": "47bdb46f-8067-4ab1-8f89-1a188a24fe35",
        "created_at": "2025-01-01T07:26:40.084195+00:00",
        "name": "client 1",
        "address": "test aaddress",
        "contact_no": "8490055445"
      },
      {
        "id": "f93f4294-3800-47fb-b3b9-7722efc6e9d8",
        "created_at": "2025-01-01T07:26:59.100951+00:00",
        "name": "client 2",
        "address": "test address",
        "contact_no": "8490055445"
      }
    ],
    "task_status": [
      {
        "task_order": 6,
        "created_at": "2025-01-07T08:57:08.726362+00:00",
        "slug": "measurement_made",
        "color": "ff321512",
        "name": "Measurement: Completed",
        "category": "Measurement"
      },
      {
        "task_order": 7,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "quotation_made",
        "color": "ff9B59B6",
        "name": "Quotation: Created",
        "category": "Quotation"
      },
      {
        "task_order": 8,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "sent_to_agency_quotation",
        "color": "ff7D3C98",
        "name": "Quotation: Shared",
        "category": "Quotation"
      },
      {
        "task_order": 9,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "quotation_accepted",
        "color": "ff1ABC9C",
        "name": "Quotation: Accepted",
        "category": "Quotation"
      },
      {
        "task_order": 10,
        "created_at": "2025-01-07T08:58:18.767105+00:00",
        "slug": "quotation_rejected",
        "color": "ff325489",
        "name": "Quotation: Rejected",
        "category": "Quotation"
      },
      {
        "task_order": 11,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "completed",
        "color": "ff2C3E50",
        "name": "Task: Completed",
        "category": "Task"
      },
      {
        "task_order": 12,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "paid",
        "color": "ff2C3E50",
        "name": "Payment: Paid",
        "category": "Payment"
      },
      {
        "task_order": 13,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "unpaid",
        "color": "ff2C3E50",
        "name": "Payment: Unpaid",
        "category": "Payment"
      },
      {
        "task_order": 1,
        "created_at": "2025-01-01T06:40:52.679867+00:00",
        "slug": "in_progress_sales",
        "color": "ff9d9bff",
        "name": "Task: In Progress",
        "category": "Task"
      },
      {
        "task_order": 2,
        "created_at": "2025-01-01T06:41:25.96586+00:00",
        "slug": "sent_to_agency",
        "color": "ff9d9bff",
        "name": "Measurement: Shared",
        "category": "Measurement"
      },
      {
        "task_order": 3,
        "created_at": "2025-01-01T06:41:42.132443+00:00",
        "slug": "accepted_by_agency",
        "color": "ff9d9bff",
        "name": "Measurement: Accepted",
        "category": "Measurement"
      },
      {
        "task_order": 4,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "rejected_by_agency",
        "color": "ff85C1E9",
        "name": "Measurement: Rejected",
        "category": "Measurement"
      },
      {
        "task_order": 5,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "in_progress_agency",
        "color": "ff28B463",
        "name": "Measurement: In Progress",
        "category": "Measurement"
      }
    ],
    "designers": [
      {
        "id": "0e408bcd-86aa-48de-a9e5-52842650816d",
        "code": 654,
        "name": "wow nice",
        "firm_name": "okay okay designers",
        "contact_no": "8878565412",
        "address": "no address pls",
        "created_at": "2025-01-03T12:01:49.068802+00:00",
        "profile_bg_color": "ff9d9bff"
      },
      {
        "id": "7da4e0ff-f6fc-4220-a135-84866574decb",
        "code": 321,
        "name": "designer 1",
        "firm_name": "yaay designers",
        "contact_no": "848954523",
        "address": "address 1",
        "created_at": "2025-01-03T12:01:17.930424+00:00",
        "profile_bg_color": "ff5cd669"
      }
    ],
    "salespersons": [
      {
        "id": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "created_at": "2025-01-02T07:35:50.240763+00:00",
        "name": "Bhushan",
        "email": "a@gmail.com",
        "role": "Salesperson",
        "profile_bg_color": "ff9d9bff"
      },
      {
        "id": "d71116c7-e5ad-4480-aad0-d546eca11021",
        "created_at": "2025-01-02T07:56:43.838588+00:00",
        "name": "Nitin",
        "email": "b@gmail.com",
        "role": "Salesperson",
        "profile_bg_color": "ffe8a4fe"
      }
    ],
    "agencies": [
      {
        "id": "f7c84cb0-f16e-4e6c-8f76-dd629007fb78",
        "created_at": "2025-01-02T07:58:17.127613+00:00",
        "name": "Jatin Tailor",
        "email": "d@gmail.com",
        "role": "Agency",
        "profile_bg_color": "ff5cd669"
      },
      {
        "id": "63e673e1-54fe-4c7b-be96-5314ba69b08f",
        "created_at": "2025-01-03T05:37:19.850478+00:00",
        "name": "ff",
        "email": "test@gmail.com",
        "role": "Agency",
        "profile_bg_color": "fffeb2c2"
      }
    ],
    "unopened_tasks": [
      {
        "task_category": "shared_tasks",
        "id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
        "deal_no": "25-0019",
        "name": "test",
        "created_at": "2025-01-07T08:26:55.63643+00:00",
        "start_date": "2025-01-07T13:47:15.812646+00:00",
        "due_date": "2025-01-09T13:47:15.811486+00:00",
        "priority": "High",
        "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "remarks": "test",
        "status": "Measurement: Shared",
        "user_ids": [
          "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
          "f7c84cb0-f16e-4e6c-8f76-dd629007fb78"
        ]
      }
    ],
    "pending_tasks": [
      {
        "task_category": "shared_tasks",
        "id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
        "deal_no": "25-0019",
        "name": "task 2",
        "created_at": "2025-01-07T08:26:55.63643+00:00",
        "start_date": "2025-01-07T13:47:15.812646+00:00",
        "due_date": "2025-01-09T13:47:15.811486+00:00",
        "priority": "Low",
        "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "remarks": "Yesyy",
        "status": "Measurement: Accepted",
        "user_ids": [
          "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
          "f7c84cb0-f16e-4e6c-8f76-dd629007fb78"
        ]
      }
    ],
    "shared_tasks": [
      {
        "task_category": "shared_tasks",
        "id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
        "deal_no": "25-0019",
        "name": "test",
        "created_at": "2025-01-07T08:26:55.63643+00:00",
        "start_date": "2025-01-07T13:47:15.812646+00:00",
        "due_date": "2025-01-09T13:47:15.811486+00:00",
        "priority": "High",
        "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "remarks": "test",
        "status": "Measurement: Shared",
        "user_ids": [
          "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
          "f7c84cb0-f16e-4e6c-8f76-dd629007fb78"
        ]
      }
    ],
    "quotation_tasks": [],
    "payment_tasks": [],
    "complete_tasks": []
  };
  static final Map<String, List<Map<String, dynamic>>>
      dummyFetchedDataProvider = {
    "task_priority": [
      {
        "created_at": "2025-01-02T07:32:12.682827+00:00",
        "name": "High",
        "color": "fff6bb54"
      },
      {
        "created_at": "2025-01-02T07:31:37.526168+00:00",
        "name": "Low",
        "color": "ff5cd669"
      },
      {
        "created_at": "2025-01-02T07:31:54.219178+00:00",
        "name": "Medium",
        "color": "ff9d9bff"
      }
    ],
    "clients": [
      {
        "id": "47bdb46f-8067-4ab1-8f89-1a188a24fe35",
        "created_at": "2025-01-01T07:26:40.084195+00:00",
        "name": "client 1",
        "address": "test aaddress",
        "contact_no": "8490055445"
      },
      {
        "id": "f93f4294-3800-47fb-b3b9-7722efc6e9d8",
        "created_at": "2025-01-01T07:26:59.100951+00:00",
        "name": "client 2",
        "address": "test address",
        "contact_no": "8490055445"
      }
    ],
    "task_status": [
      {
        "task_order": 6,
        "created_at": "2025-01-07T08:57:08.726362+00:00",
        "slug": "measurement_made",
        "color": "ff321512",
        "name": "Measurement: Completed",
        "category": "Measurement"
      },
      {
        "task_order": 7,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "quotation_made",
        "color": "ff9B59B6",
        "name": "Quotation: Created",
        "category": "Quotation"
      },
      {
        "task_order": 8,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "sent_to_agency_quotation",
        "color": "ff7D3C98",
        "name": "Quotation: Shared",
        "category": "Quotation"
      },
      {
        "task_order": 9,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "quotation_accepted",
        "color": "ff1ABC9C",
        "name": "Quotation: Accepted",
        "category": "Quotation"
      },
      {
        "task_order": 10,
        "created_at": "2025-01-07T08:58:18.767105+00:00",
        "slug": "quotation_rejected",
        "color": "ff325489",
        "name": "Quotation: Rejected",
        "category": "Quotation"
      },
      {
        "task_order": 11,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "completed",
        "color": "ff2C3E50",
        "name": "Task: Completed",
        "category": "Task"
      },
      {
        "task_order": 12,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "paid",
        "color": "ff2C3E50",
        "name": "Payment: Paid",
        "category": "Payment"
      },
      {
        "task_order": 13,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "unpaid",
        "color": "ff2C3E50",
        "name": "Payment: Unpaid",
        "category": "Payment"
      },
      {
        "task_order": 1,
        "created_at": "2025-01-01T06:40:52.679867+00:00",
        "slug": "in_progress_sales",
        "color": "ff9d9bff",
        "name": "Task: In Progress",
        "category": "Task"
      },
      {
        "task_order": 2,
        "created_at": "2025-01-01T06:41:25.96586+00:00",
        "slug": "sent_to_agency",
        "color": "ff9d9bff",
        "name": "Measurement: Shared",
        "category": "Measurement"
      },
      {
        "task_order": 3,
        "created_at": "2025-01-01T06:41:42.132443+00:00",
        "slug": "accepted_by_agency",
        "color": "ff9d9bff",
        "name": "Measurement: Accepted",
        "category": "Measurement"
      },
      {
        "task_order": 4,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "rejected_by_agency",
        "color": "ff85C1E9",
        "name": "Measurement: Rejected",
        "category": "Measurement"
      },
      {
        "task_order": 5,
        "created_at": "2025-01-06T06:39:30.008843+00:00",
        "slug": "in_progress_agency",
        "color": "ff28B463",
        "name": "Measurement: In Progress",
        "category": "Measurement"
      }
    ],
    "designers": [
      {
        "id": "0e408bcd-86aa-48de-a9e5-52842650816d",
        "code": 654,
        "name": "wow nice",
        "firm_name": "okay okay designers",
        "contact_no": "8878565412",
        "address": "no address pls",
        "created_at": "2025-01-03T12:01:49.068802+00:00",
        "profile_bg_color": "ff9d9bff"
      },
      {
        "id": "7da4e0ff-f6fc-4220-a135-84866574decb",
        "code": 321,
        "name": "designer 1",
        "firm_name": "yaay designers",
        "contact_no": "848954523",
        "address": "address 1",
        "created_at": "2025-01-03T12:01:17.930424+00:00",
        "profile_bg_color": "ff5cd669"
      }
    ],
    "salespersons": [
      {
        "id": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "created_at": "2025-01-02T07:35:50.240763+00:00",
        "name": "Bhushan",
        "email": "a@gmail.com",
        "role": "Salesperson",
        "profile_bg_color": "ff9d9bff"
      },
      {
        "id": "d71116c7-e5ad-4480-aad0-d546eca11021",
        "created_at": "2025-01-02T07:56:43.838588+00:00",
        "name": "Nitin",
        "email": "b@gmail.com",
        "role": "Salesperson",
        "profile_bg_color": "ffe8a4fe"
      }
    ],
    "agencies": [
      {
        "id": "f7c84cb0-f16e-4e6c-8f76-dd629007fb78",
        "created_at": "2025-01-02T07:58:17.127613+00:00",
        "name": "Jatin Tailor",
        "email": "d@gmail.com",
        "role": "Agency",
        "profile_bg_color": "ff5cd669"
      },
      {
        "id": "63e673e1-54fe-4c7b-be96-5314ba69b08f",
        "created_at": "2025-01-03T05:37:19.850478+00:00",
        "name": "ff",
        "email": "test@gmail.com",
        "role": "Agency",
        "profile_bg_color": "fffeb2c2"
      }
    ],
    "unopened_tasks": [
      {
        "task_category": "shared_tasks",
        "id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
        "deal_no": "25-0019",
        "name": "test",
        "created_at": "2025-01-07T08:26:55.63643+00:00",
        "start_date": "2025-01-07T13:47:15.812646+00:00",
        "due_date": "2025-01-09T13:47:15.811486+00:00",
        "priority": "High",
        "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "remarks": "test",
        "status": "Measurement: Shared",
        "user_ids": [
          "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
          "f7c84cb0-f16e-4e6c-8f76-dd629007fb78"
        ]
      }
    ],
    "pending_tasks": [
      {
        "task_category": "shared_tasks",
        "id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
        "deal_no": "25-0019",
        "name": "test",
        "created_at": "2025-01-07T08:26:55.63643+00:00",
        "start_date": "2025-01-07T13:47:15.812646+00:00",
        "due_date": "2025-01-09T13:47:15.811486+00:00",
        "priority": "High",
        "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "remarks": "test",
        "status": "Measurement: Shared",
        "user_ids": [
          "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
          "f7c84cb0-f16e-4e6c-8f76-dd629007fb78"
        ]
      }
    ],
    "shared_tasks": [
      {
        "task_category": "shared_tasks",
        "id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
        "deal_no": "25-0019",
        "name": "test",
        "created_at": "2025-01-07T08:26:55.63643+00:00",
        "start_date": "2025-01-07T13:47:15.812646+00:00",
        "due_date": "2025-01-09T13:47:15.811486+00:00",
        "priority": "High",
        "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "remarks": "test",
        "status": "Measurement: Shared",
        "user_ids": [
          "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
          "f7c84cb0-f16e-4e6c-8f76-dd629007fb78"
        ]
      }
    ],
    "quotation_tasks": [],
    "payment_tasks": [],
    "complete_tasks": []
  };
  static final dummyTask = [
    {
      "task_category": "shared_tasks",
      "id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
      "deal_no": "25-0019",
      "name": "test",
      "created_at": "2025-01-07T08:26:55.63643+00:00",
      "start_date": "2025-01-07T13:47:15.812646+00:00",
      "due_date": "2025-01-09T13:47:15.811486+00:00",
      "priority": "High",
      "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
      "remarks": "test",
      "status": "Measurement: Shared",
      "user_ids": [
        "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "f7c84cb0-f16e-4e6c-8f76-dd629007fb78"
      ]
    },
    {
      "task_category": "shared_tasks",
      "id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
      "deal_no": "25-0019",
      "name": "test",
      "created_at": "2025-01-07T08:26:55.63643+00:00",
      "start_date": "2025-01-07T13:47:15.812646+00:00",
      "due_date": "2025-01-09T13:47:15.811486+00:00",
      "priority": "High",
      "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
      "remarks": "test",
      "status": "Measurement: Shared",
      "user_ids": [
        "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
        "f7c84cb0-f16e-4e6c-8f76-dd629007fb78"
      ]
    },
  ];
  static final dummyTaskCounts = {
    "Task: In Progress": 1,
    "Measurement: Shared": 1,
    "Measurement: Accepted": 1,
    "Measurement: Rejected": 1,
    "Measurement: In Progress": 1,
    "Measurement: Completed": 1,
    "Quotation: Created": 1,
    "Quotation: Shared": 1,
    "Quotation: Accepted": 1,
    "Quotation: Rejected": 1,
    "Task: Completed": 1,
    "Payment: Paid": 1,
    "Payment: Unpaid": 1,
  };
}
