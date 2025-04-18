class Service {
  final String type;
  final int quantity;
  final double rate;
  final double amount;

  Service({
    required this.type,
    required this.quantity,
    required this.rate,
    required this.amount,
  });

  // Factory constructor to create a Service from a Map
  factory Service.fromMap(Map<String, dynamic> map) => Service(
    type: map['location'] ?? '',
    quantity: (map['quantity'] ?? 0.00),
    rate: map['rate'] ?? '',
    amount: map['amount'] ?? '',
  );

  // Convert Service to Map
  Map<String, dynamic> toMap() => {
    'location': type,
    'quantity': quantity,
    'rate': rate,
    'amount': amount,
  };

  static Service get empty =>
      Service(type: '', quantity: 0, rate: 0.00, amount: 1);
}
