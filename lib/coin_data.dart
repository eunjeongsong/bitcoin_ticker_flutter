import 'dart:convert';

import 'package:bitcoin_ticker/key.dart';
import 'package:http/http.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = "https://rest.coinapi.io/v1/exchangerate";

class CoinData {
  Future<dynamic> getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      Uri requestURL =
          Uri.parse("$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey");
      Response response = await get(requestURL);

      if (response.statusCode == 200) {
        String data = response.body;
        dynamic decodedData = jsonDecode(data);

        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
