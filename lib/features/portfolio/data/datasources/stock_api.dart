import 'dart:convert';

import 'package:http/http.dart' as http;

class StockApi {
  Future<double> getPrice(String symbol) async {
    var url = Uri.parse(
      'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=T7VE8W3CJ9A4B794',
    );
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return double.parse(data['Global Quote']['05. price']);
  }
}
