import 'package:base_structure/core/repositories/repository.dart';
import 'package:base_structure/core/result/result.dart';
import 'package:base_structure/domain/entities/currency_entity.dart';

import '../../core/error/base_error.dart';
import '../../data/models/currency_model.dart';
import '../../data/requests/pokemon_request.dart';

abstract class PokemonRepository extends Repository {
  Future<Result<BaseError, List<PokemonModel>>> getPokemonList(PokemonRequest pokemonRequest);

}
