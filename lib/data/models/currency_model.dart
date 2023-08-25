import 'package:base_structure/core/models/base_model.dart';
import 'package:base_structure/domain/entities/currency_entity.dart';
import 'package:flutter/cupertino.dart';

class PokemonModel {
  String? name;
  String? image;

  PokemonModel({this.name, this.image});

  PokemonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    String? id;
    if (json['url'] != null) {
      final data = (json['url'] as String);
      final newString = data.substring(0, data.length - 1);

      id = newString.substring(newString.lastIndexOf('/') + 1);
    }
    image = id != null
        ? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png'
        : null;
  }

// @override
// CurrencyEntity toEntity() =>
//     CurrencyEntity(flag: flag,
//         code: code,
//         currency: currency,
//         buy: buy,
//         sell: sell);
}
