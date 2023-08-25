import 'package:dartz/dartz.dart';
import 'package:base_structure/core/error/base_error.dart';
import 'package:base_structure/core/result/result.dart';
import 'package:base_structure/data/datasources/exchage_data_source/pokemon_data_source.dart';
import 'package:base_structure/data/models/currency_model.dart';
import 'package:base_structure/data/requests/pokemon_request.dart';
import 'package:base_structure/domain/entities/currency_entity.dart';

import '../../domain/repositories/exchange_repository.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  final PokemonDataSource exchangeDataSource;

  PokemonRepositoryImpl(this.exchangeDataSource);

  @override
  Future<Result<BaseError, List<PokemonModel>>> getPokemonList(
      PokemonRequest pokemonRequest) async {
    final result = await exchangeDataSource.getPokemonList(pokemonRequest);
    return executeWithoutConvert(remoteResult: result);
  }
}
