// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyResponse _$CurrencyResponseFromJson(Map<String, dynamic> json) =>
    CurrencyResponse(
      CurrencyQuery.fromJson(json['query'] as Map<String, dynamic>),
      (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$CurrencyResponseToJson(CurrencyResponse instance) =>
    <String, dynamic>{
      'query': instance.query,
      'data': instance.data,
    };

CurrencyQuery _$CurrencyQueryFromJson(Map<String, dynamic> json) =>
    CurrencyQuery(
      json['apikey'] as String,
      json['base_currency'] as String,
      json['timestamp'] as int,
    );

Map<String, dynamic> _$CurrencyQueryToJson(CurrencyQuery instance) =>
    <String, dynamic>{
      'apikey': instance.apikey,
      'base_currency': instance.base_currency,
      'timestamp': instance.timestamp,
    };
