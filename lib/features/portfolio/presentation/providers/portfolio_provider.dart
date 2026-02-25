import 'package:flutter_riverpod/legacy.dart';

import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/entities/stock.dart';

final portfolioProvider=StateNotifierProvider<PortfolioNotifier,List<Stock>>((ref)=>PortfolioNotifier());
class PortfolioNotifier  extends StateNotifier<List<Stock>>{
  PortfolioRepositoryImpl repo=PortfolioRepositoryImpl();
  PortfolioNotifier():super([]);
  Future<void> addStock(String symbol) async {
    Stock stock = await repo.getStock(symbol);
    state = repo.getPortfolio();
  }

}