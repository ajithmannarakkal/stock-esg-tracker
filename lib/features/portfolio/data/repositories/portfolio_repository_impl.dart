import 'package:stock_esg_tracker/features/portfolio/data/datasources/esg_api.dart';
import 'package:stock_esg_tracker/features/portfolio/data/datasources/stock_api.dart';

import '../../domain/entities/stock.dart';
import '../../domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  List<Stock> portfolio = [];

  StockApi stockAPI = StockApi();
  ESGApi esgApi = ESGApi();
  @override
  Future<Stock> getStock(String symbol) async {
    double price = await stockAPI.getPrice(symbol);
    var esg = await esgApi.getESG(symbol);
    return Stock(
      symbol: symbol,
      price: price,
      esgScore: esg['esg'],
      co2: esg['co2'],
    );
  }
  @override
  List<Stock> getPortfolio() {
    return portfolio;
  }
  @override
  void addStock(Stock stock) {
    portfolio.add(stock);
  }
}
