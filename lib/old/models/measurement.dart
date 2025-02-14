class AdditionalCost {
  String name;
  double rate;
  double qty;
  double total;

  AdditionalCost({required this.name, required this.rate, required this.qty})
      : total = rate * qty;
}
