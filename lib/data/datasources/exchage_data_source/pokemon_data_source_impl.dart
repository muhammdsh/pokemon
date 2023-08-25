import 'package:dartz/dartz.dart';
import 'package:base_structure/core/datasources/api_call_params.dart';
import 'package:base_structure/core/datasources/function_instance.dart';
import 'package:base_structure/core/enums/api/HttpMethod.dart';
import 'package:base_structure/core/resources/apis.dart';
import 'package:base_structure/data/datasources/exchage_data_source/pokemon_data_source.dart';

import '../../../core/error/base_error.dart';
import '../../models/currency_model.dart';
import '../../requests/pokemon_request.dart';
import '../../responses/pokemon_response.dart';

class PokemonDataSourceImpl extends PokemonDataSource {
  @override
  Future<Either<BaseError, List<PokemonModel>>> getPokemonList(PokemonRequest pokemonRequest) {
    return request<List<PokemonModel>, PokemonResponse>(ApiCallParams<PokemonResponse>(
        responseStr: "PokemonResponse",
        mapper: (json) => PokemonResponse.fromJson(json),
        data: pokemonRequest.toJson(),
        method: HttpMethod.GET,
        url: ApiUrls.getPokemonList));
  }
}
