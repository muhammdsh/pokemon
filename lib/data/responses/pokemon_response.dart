import 'package:base_structure/data/models/currency_model.dart';

import '../../core/response/api_response.dart';

class PokemonResponse extends ApiResponse<List<PokemonModel>> {
  PokemonResponse(
    String msg,
    bool hasError,
    List<PokemonModel> result,
  ) : super(msg, hasError, result);

  factory PokemonResponse.fromJson(json) {
    String message = '';
    bool isSuccess = false;
    if (json != null && json['results'] is List) {
      isSuccess = (json['results'] as List).isNotEmpty;
    }
    List<PokemonModel> model = [];

    if (isSuccess) {
      model = (json['results'] as List).map((e) {
        return PokemonModel.fromJson(e);
      }).toList();
    } else {
      message = "Something went wrong";
    }

    return PokemonResponse(message, !isSuccess, model);
  }
}
