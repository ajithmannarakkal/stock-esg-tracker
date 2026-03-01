import 'dart:convert';

import 'package:http/http.dart' as http;

class StockApi {
  static const _apiKey = 'T7VE8W3CJ9A4B794';

  Future<double> getPrice(String symbol) async {
    try {
      var url = Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$_apiKey',
      );
      var response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch stock price');
      }

      var data = jsonDecode(response.body);

      // check for rate limit / info messages
      if (data.containsKey('Information') || data.containsKey('Note')) {
        throw Exception('API rate limit reached. Try again later.');
      }

      var quote = data['Global Quote'];
      if (quote == null || quote['05. price'] == null) {
        throw Exception('No data found for symbol: $symbol');
      }

      return double.parse(quote['05. price']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, String>>> searchSymbol(String query) async {
    try {
      var url = Uri.parse(
        'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$query&apikey=$_apiKey',
      );
      var response = await http.get(url);

      if (response.statusCode != 200) {
        return [];
      }

      var data = jsonDecode(response.body);

      if (data.containsKey('Information') || data.containsKey('Note')) {
        return [];
      }

      var matches = data['bestMatches'] as List? ?? [];
      return matches.map<Map<String, String>>((item) {
        return {
          'symbol': item['1. symbol'] ?? '',
          'name': item['2. name'] ?? '',
        };
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
