import 'package:base_structure/core/error/base_error.dart';
import 'package:base_structure/core/param/no_param.dart';
import 'package:base_structure/core/result/result.dart';
import 'package:base_structure/core/usecases/base_use_case.dart';
import 'package:base_structure/domain/entities/currency_entity.dart';

import '../repositories/exchange_repository.dart';

class GetCurrencyUseCase extends UseCase<Future<Result<BaseError, CurrenciesDataEntity>>, NoParams> {
  final ExchangeRepository exchangeRepository;

  GetCurrencyUseCase(this.exchangeRepository);

  @override
  Future<Result<BaseError, CurrenciesDataEntity>> call(NoParams params) async {
    final dateNow = DateTime.now();
    final String lastUpdate =
        "${dateNow.day.toString()}/${dateNow.month.toString()}/${dateNow.year}";

    final result = await exchangeRepository.getCurrencies();
    if (result.hasDataOnly) {
      return Result(data: CurrenciesDataEntity(currencies: result.data!, lastUpdate: lastUpdate));
    }

    return Result(error: result.error);
  }
}


