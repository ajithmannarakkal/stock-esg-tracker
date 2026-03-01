class Stock {
  final String symbol;
  final double price;
  final double esgScore;
  final double co2;
  final int quantity;
  final String sustainabilityRating;

  Stock({
    required this.symbol,
    required this.price,
    required this.esgScore,
    required this.co2,
    this.quantity = 1,
    this.sustainabilityRating = 'C',
  });
}