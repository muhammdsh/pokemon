import 'package:base_structure/core/param/base_param.dart';

import '../../core/usecases/base_use_case.dart';

class ConvertExchangeUseCase extends UseCase<double, ConvertExchangeParams> {
  @override
  double call(ConvertExchangeParams params) {
    double sekAmount = params.amount * (params.fromSellCurrency / params.fromByCurrency);
    return sekAmount * (params.toByCurrency / params.toSellCurrency);
    // return params.amount / (params.toByCurrency * params.fromSellCurrency);
  }
}

class ConvertExchangeParams extends BaseParams {
  final double amount;
  final double fromSellCurrency;
  final double toSellCurrency;
  final double fromByCurrency;
  final double toByCurrency;

  ConvertExchangeParams(
      {required this.amount,
      required this.fromSellCurrency,
      required this.toByCurrency,
      required this.fromByCurrency,
      required this.toSellCurrency});
}
