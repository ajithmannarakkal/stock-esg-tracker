import '../../domain/entities/stock.dart';

class StockModel extends Stock {
  StockModel({
    required super.symbol,
    required super.price,
    required super.esgScore,
    required super.co2,
    super.quantity,
    super.sustainabilityRating,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['symbol'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      esgScore: (json['esgScore'] ?? 50).toDouble(),
      co2: (json['co2'] ?? 300).toDouble(),
      quantity: json['quantity'] ?? 1,
      sustainabilityRating: json['sustainabilityRating'] ?? 'C',
    );
  }
}
