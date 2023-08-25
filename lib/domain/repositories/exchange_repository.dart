import 'package:base_structure/core/repositories/repository.dart';
import 'package:base_structure/core/result/result.dart';
import 'package:base_structure/domain/entities/currency_entity.dart';

import '../../core/error/base_error.dart';

abstract class ExchangeRepository extends Repository {
  Future<Result<BaseError, List<CurrencyEntity>>> getCurrencies();

}
