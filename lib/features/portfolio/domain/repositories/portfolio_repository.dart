import '../entities/stock.dart';

abstract class PortfolioRepository {
  Future<Stock> getStock(String symbol) ;
List<Stock> getPortfolio();
void addStock(Stock stock);
}