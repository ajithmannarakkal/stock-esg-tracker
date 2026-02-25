import '../../domain/entities/stock.dart';

class StockModel extends Stock {
  StockModel({
    required String symbol,
    required double price,
    required double esgScore,
    required double co2,
  }) : super(symbol: symbol, price: price, esgScore: esgScore, co2: co2);
}
