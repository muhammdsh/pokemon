import 'package:dartz/dartz.dart';
import 'package:base_structure/core/error/base_error.dart';
import 'package:base_structure/core/result/result.dart';
import 'package:base_structure/data/datasources/exchage_data_source/exchange_data_source.dart';
import 'package:base_structure/data/models/currency_model.dart';
import 'package:base_structure/data/requests/exchange_request.dart';
import 'package:base_structure/domain/entities/currency_entity.dart';

import '../../domain/repositories/exchange_repository.dart';



class ExchangeRepositoryImpl extends ExchangeRepository {
  final ExchangeDataSource exchangeDataSource;

  ExchangeRepositoryImpl(this.exchangeDataSource);

  @override
  Future<Result<BaseError, List<CurrencyEntity>>> getCurrencies() async {
    final memoizedResult = getMemoizedResult(request:DefaultRequest() );
    Either<BaseError, List<CurrencyModel>> result;
    if (memoizedResult == null) {
      result = await exchangeDataSource.getCurrencies();
      memoizeResult(result: result, request: DefaultRequest());
    } else {
      result = getMemoizedResult(request: DefaultRequest())
          as Either<BaseError, List<CurrencyModel>>;
    }
    return executeWithList(remoteResult: result);
  }


}

