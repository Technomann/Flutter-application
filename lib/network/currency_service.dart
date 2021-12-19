
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/model/json/currency_response.dart';
import 'package:fluttertoast/fluttertoast.dart';

const _freeCurrencyApiKey = "d4cf0060-510b-11ec-98fa-715ecd1e0db9";
const _baseURL = "https://freecurrencyapi.net/api/v2/";

class CurrencyService{
  var dio = Dio();

  CurrencyService(){
    dio.options.baseUrl = _baseURL;
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler){
          Fluttertoast.showToast(
              msg: error.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      )
    );
    dio.interceptors.add(LogInterceptor());
  }

  Future<CurrencyResponse> getCurrencies() async {
    var response = await dio.get(
      "latest",
      queryParameters: {
        "apikey": _freeCurrencyApiKey,
        "base_currency": "HUF"
      }
    );

    return CurrencyResponse.fromJson(response.data);
  }
}