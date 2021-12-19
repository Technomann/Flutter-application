
import 'package:json_annotation/json_annotation.dart';

part 'currency_response.g.dart';

@JsonSerializable()
class CurrencyResponse{
  CurrencyQuery query;
  Map<String, double> data;

  CurrencyResponse(this.query, this.data);

  dynamic toJson() => _$CurrencyResponseToJson(this);
  factory CurrencyResponse.fromJson(Map<String, dynamic> obj) => _$CurrencyResponseFromJson(obj);
}

@JsonSerializable()
class CurrencyQuery{
  String apikey;
  String base_currency;
  int timestamp;

  CurrencyQuery(this.apikey, this.base_currency, this.timestamp);

  dynamic toJson() => _$CurrencyQueryToJson(this);
  factory CurrencyQuery.fromJson(Map<String, dynamic> obj) => _$CurrencyQueryFromJson(obj);
}