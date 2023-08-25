import 'package:base_structure/core/error/base_error.dart';
import 'package:base_structure/core/param/base_param.dart';
import 'package:base_structure/core/request/request.dart';
import 'package:base_structure/core/result/result.dart';
import 'package:base_structure/data/models/currency_model.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/bloc/infinite_list_bloc.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/entity/pagination_params.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/entity/pokemon_wrappers.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/presentation/pagination_builder.dart';
import 'package:flutter/material.dart';

import 'dart:convert';


typedef AsyncCallbackWithParams<T> = Future<T> Function(BaseParams b);
typedef BuilderType<T> = Widget Function(T data, int index);

class WrapperParams {
  final int startIndex;
  final Map<String, dynamic> extraParams;

  WrapperParams(this.startIndex, this.extraParams);

  WrapperParams copyWith({int? startIndex, Map<String, dynamic>? extraParams}) {
    return PaginationParams(
        startIndex: startIndex ?? this.startIndex, extraParams: extraParams ?? this.extraParams);
  }
}

abstract class UseCaseWrapper<T, P extends WrapperParams> {
  Future<List<T>?> caller(P params);

  Future<List<T>?> responseChecker(Result<BaseError, List<T>?> response) async {
    if (response.hasDataOnly) {
      return response.data;
    } else if (response.hasErrorOnly) {
      throw Exception(response.error.toString());
    }
    return null;
  }
}

extension PainationUseCaseBuilder on UseCaseWrapper {
  Widget buildPaginationList<T>({
    Map<String, dynamic>? extraParams,
    required BuilderType<T> listBuilder,
    required BuilderType<T> gridBuilder,
    BuilderType<T>? sliverBuilder,
    Key? builderKey,
    PaginationController? controller,
    ScrollController? scrollController,
    bool? customPagination,
    ListType? listType,
    void Function(int id, int index, bool hasChild)? onPressed,
    int? currentId,
  }) {
    switch (runtimeType) {
      case GetPokemon:
        return _buildPokemonList(
            builderKey: builderKey,
            extraParams: extraParams,
            scrollController: scrollController,
            listBuilder: listBuilder as BuilderType<PokemonModel>,
            gridBuilder: gridBuilder as BuilderType<PokemonModel>,
            controller: controller as PaginationController<PokemonModel>?,
            customPagination: customPagination ?? false,
            sliverBuilder: sliverBuilder as BuilderType<PokemonModel>?);



      default:
        return Container();
    }
  }
}

extension Builders on UseCaseWrapper {
  Widget _buildPokemonList(
      {Key? builderKey,
      Map<String, dynamic>? extraParams,
      required BuilderType<PokemonModel> listBuilder,
      required BuilderType<PokemonModel> gridBuilder,
      ScrollController? scrollController,
      ListType? listType,
      BuilderType<PokemonModel>? sliverBuilder,
      bool? customPagination,
      PaginationController<PokemonModel>? controller}) {
    return PaginationBuilder<PokemonModel>(
      key: builderKey,
      type: listType ?? ListType.list,
      flex: 10,
      controller: controller,
      extraParams: extraParams,
      scrollController: scrollController,
      customPagination: customPagination ?? false,
      useCase: this,
      listBuilder: listBuilder,
      gridBuilder: gridBuilder,
      sliverBuilder: sliverBuilder,
    );
  }


}
