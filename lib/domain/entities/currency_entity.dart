import 'package:base_structure/core/entities/base_entity.dart';
import 'package:flutter/cupertino.dart';


class CurrenciesDataEntity extends BaseEntity {
  final List<CurrencyEntity> currencies;
  final String lastUpdate;


  CurrenciesDataEntity({this.currencies = const [], this.lastUpdate = ""});

  @override
  List<Object> get props => [currencies, lastUpdate];

}

class CurrencyEntity extends BaseEntity {
  final String code;
  final String currency;
  final String sell;
  final String buy;
  final String flag;

 const CurrencyEntity({
     this.code = '' ,
     this.currency= "",
     this.sell= "",
     this.buy= "",
     this.flag= "",
  });


  @override
  List<Object> get props => [flag, currency, code, sell, buy];
}
