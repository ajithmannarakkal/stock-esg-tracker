class ESGApi {
  // hardcoded ESG data for common stocks
  // in a real app this would come from an external API
  final Map<String, dynamic> esgData = {
    'AAPL': {'esg': 80.0, 'co2': 200.0},
    'TSLA': {'esg': 60.0, 'co2': 400.0},
    'MSFT': {'esg': 85.0, 'co2': 150.0},
    'GOOGL': {'esg': 82.0, 'co2': 180.0},
    'AMZN': {'esg': 55.0, 'co2': 500.0},
    'META': {'esg': 58.0, 'co2': 350.0},
    'NVDA': {'esg': 72.0, 'co2': 220.0},
    'NFLX': {'esg': 65.0, 'co2': 280.0},
    'JPM': {'esg': 50.0, 'co2': 600.0},
    'V': {'esg': 70.0, 'co2': 100.0},
    'JNJ': {'esg': 78.0, 'co2': 320.0},
    'WMT': {'esg': 45.0, 'co2': 700.0},
    'DIS': {'esg': 68.0, 'co2': 250.0},
    'MA': {'esg': 71.0, 'co2': 110.0},
    'INTC': {'esg': 75.0, 'co2': 240.0},
  };

  Future<Map<String, dynamic>> getESG(String symbol) async {
    // simulate a tiny API delay
    await Future.delayed(Duration(milliseconds: 100));

    return esgData[symbol.toUpperCase()] ?? {
      'esg': 50.0,
      'co2': 300.0,
    };
  }

  /// derives a simple sustainability rating from the ESG score
  static String getSustainabilityRating(double esgScore) {
    if (esgScore >= 80) return 'A';
    if (esgScore >= 65) return 'B';
    if (esgScore >= 50) return 'C';
    if (esgScore >= 35) return 'D';
    return 'F';
  }
}