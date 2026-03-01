import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/entities/stock.dart';

final portfolioProvider =
    NotifierProvider<PortfolioNotifier, List<Stock>>(
  PortfolioNotifier.new,
);

class PortfolioNotifier extends Notifier<List<Stock>> {
  final PortfolioRepositoryImpl _repo = PortfolioRepositoryImpl();
  bool isLoading = false;
  String? errorMessage;

  @override
  List<Stock> build() => [];

  Future<void> addStock(String symbol) async {
    if (symbol.trim().isEmpty) return;

    isLoading = true;
    errorMessage = null;
    state = [...state];

    try {
      Stock stock = await _repo.getStock(symbol.trim().toUpperCase());
      _repo.addStock(stock);
      isLoading = false;
      state = [..._repo.getPortfolio()];
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString().replaceAll('Exception: ', '');
      state = [...state];
    }
  }

  void removeStock(String symbol) {
    _repo.removeStock(symbol);
    state = [..._repo.getPortfolio()];
  }

  Future<List<Map<String, String>>> searchStocks(String query) async {
    if (query.trim().isEmpty) return [];
    return await _repo.searchStocks(query);
  }
}