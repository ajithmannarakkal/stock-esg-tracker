import 'package:stock_esg_tracker/features/portfolio/data/datasources/esg_api.dart';
import 'package:stock_esg_tracker/features/portfolio/data/datasources/stock_api.dart';

import '../../domain/entities/stock.dart';
import '../../domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final List<Stock> _portfolio = [];

  final StockApi _stockApi = StockApi();
  final ESGApi _esgApi = ESGApi();

  @override
  Future<Stock> getStock(String symbol) async {
    double price = await _stockApi.getPrice(symbol);
    var esg = await _esgApi.getESG(symbol);
    double esgScore = esg['esg'];
    String rating = ESGApi.getSustainabilityRating(esgScore);

    return Stock(
      symbol: symbol.toUpperCase(),
      price: price,
      esgScore: esgScore,
      co2: esg['co2'],
      sustainabilityRating: rating,
    );
  }

  @override
  List<Stock> getPortfolio() {
    return List.from(_portfolio);
  }

  @override
  void addStock(Stock stock) {
    // don't add duplicates
    bool exists = _portfolio.any(
      (s) => s.symbol == stock.symbol,
    );
    if (!exists) {
      _portfolio.add(stock);
    }
  }

  @override
  void removeStock(String symbol) {
    _portfolio.removeWhere(
      (s) => s.symbol == symbol,
    );
  }

  @override
  Future<List<Map<String, String>>> searchStocks(String query) async {
    return await _stockApi.searchSymbol(query);
  }
}
