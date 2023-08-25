import 'package:base_structure/core/request/request.dart';

class PokemonRequest extends Request {
  final String limit;
  final String offset;

  PokemonRequest({required this.limit, required this.offset});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['limit'] = limit;
    map['offset'] = offset;

    return map;
  }
}
