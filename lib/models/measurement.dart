class AdditionalCost {
  String name;
  double rate;
  double area;
  double total;

  AdditionalCost({required this.name, required this.rate, required this.area})
      : total = rate * area;
}
