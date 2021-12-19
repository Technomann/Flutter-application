
import 'package:flutter_hf/model/currency.dart';
import 'package:flutter_hf/network/currency_service.dart';

class CurrencyRepository{
  var service = CurrencyService();

  Future<List<Currency>> getCurrencies() async {
    var response = await service.getCurrencies();
    List<Currency> list = [];
    List<String> currencyNames = const ["EUR", "USD", "GBP", "NGN", "INR", "RUB", "JPY"];

    DateTime today = DateTime.now();
    String date = today.year.toString() + "-"
        + today.month.toString() + "-"
        + today.day.toString() + "  "
        + today.hour.toString() + ":"
        + today.minute.toString();

    for(int i = 0; i < 7; ++i){
      Currency temp = Currency(currencyNames[i], 1.0/response.data[currencyNames[i]]!, date);
      list.add(temp);
    }
    return list;
  }
}