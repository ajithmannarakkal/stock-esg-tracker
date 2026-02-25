class ESGApi {

  Map<String,dynamic> esgData = {

    "AAPL":{
      "esg":80.0,
      "co2":200.0
    },

    "TSLA":{
      "esg":60.0,
      "co2":400.0
    },

    "MSFT":{
      "esg":85.0,
      "co2":150.0
    }

  };

  Future<Map<String,dynamic>> getESG(String symbol) async{

    return esgData[symbol] ??
        {
          "esg":50.0,
          "co2":300.0
        };

  }

}