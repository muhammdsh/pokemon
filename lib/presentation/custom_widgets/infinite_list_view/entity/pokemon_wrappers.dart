import 'package:base_structure/domain/usecases/get_currencies_usecases.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/entity/pagination_params.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/entity/usecase_wrapper.dart';

import '../../../../data/models/currency_model.dart';

class GetPokemon extends UseCaseWrapper<PokemonModel, PaginationParams> {
  final PokemonUseCase _getPokemonUseCase;

  GetPokemon(this._getPokemonUseCase);

  @override
  Future<List<PokemonModel>?> caller(PaginationParams params) async {
    final response = await _getPokemonUseCase(PokemonParams(
      limit: params.limit.toString(),
      offset: (params.startIndex * params.limit).toString(),
    ));
    return responseChecker(response);
  }
}
