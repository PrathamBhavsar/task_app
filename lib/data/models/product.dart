class Product {
  final String name;
  final String company;
  final int amount;

  Product({required this.name, required this.amount, required this.company});

  // Factory constructor to create an Product from a Map
  factory Product.fromMap(Map<String, dynamic> map) => Product(
    name: map['name'],
    amount: map['services'],
    company: map['company'],
  );

  // Convert Product to Map
  Map<String, dynamic> toMap() => {'name': name, 'services': amount};

  // Sample list of appointments
  static List<Product> get sampleProducts => [
    Product(name: "Shampoo", amount: 20, company: 'LuxeHair'),
    Product(name: "Conditioner", amount: 25, company: 'StylePro'),
    Product(name: "Hair Serum", amount: 15, company: 'LuxeHair'),
    Product(name: "Styling Gel", amount: 10, company: 'ColorMaster'),
    Product(name: "Pomade", amount: 18, company: 'GlamNails'),
  ];
  static List<String> get names => sampleProducts.map((s) => s.name).toList();
}
