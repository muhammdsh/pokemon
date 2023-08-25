import 'package:dartz/dartz.dart';
import 'package:base_structure/core/datasources/remote_data_source.dart';
import 'package:base_structure/core/error/base_error.dart';

import '../../models/currency_model.dart';
import '../../requests/pokemon_request.dart';


abstract class PokemonDataSource extends RemoteDataSource {
  Future<Either<BaseError, List<PokemonModel>>> getPokemonList(PokemonRequest pokemonRequest);


}
