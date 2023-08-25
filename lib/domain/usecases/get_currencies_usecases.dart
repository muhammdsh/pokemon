import 'package:base_structure/core/error/base_error.dart';
import 'package:base_structure/core/param/base_param.dart';
import 'package:base_structure/core/param/no_param.dart';
import 'package:base_structure/core/result/result.dart';
import 'package:base_structure/core/usecases/base_use_case.dart';
import 'package:base_structure/data/requests/pokemon_request.dart';
import 'package:base_structure/domain/entities/currency_entity.dart';

import '../../data/models/currency_model.dart';
import '../repositories/exchange_repository.dart';

class PokemonUseCase extends UseCase<Future<Result<BaseError, List<PokemonModel>>>, PokemonParams> {
  final PokemonRepository pokemonRepository;

  PokemonUseCase(this.pokemonRepository);

  @override
  Future<Result<BaseError, List<PokemonModel>>> call(PokemonParams params) async {
    return pokemonRepository.getPokemonList(
        PokemonRequest(limit: params.limit, offset: params.offset));
  }
}

class PokemonParams extends BaseParams {
  final String offset;
  final String limit;

  PokemonParams({required this.offset, required this.limit});
}
