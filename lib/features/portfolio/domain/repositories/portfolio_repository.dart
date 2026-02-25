import '../entities/stock.dart';

abstract class PortfolioRepository {
  Future<Stock> getStock(String symbol) ;

}