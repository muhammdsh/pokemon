import 'package:base_structure/app+injection/di.dart';
import 'package:base_structure/core/helper/screen_util/screen_helper.dart';
import 'package:base_structure/data/models/currency_model.dart';
import 'package:base_structure/domain/usecases/get_currencies_usecases.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/entity/pokemon_wrappers.dart';
import 'package:base_structure/presentation/custom_widgets/infinite_list_view/entity/usecase_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../custom_widgets/custom_app_bar.dart';
import '../components/pokemon_card.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pokemons'),
      body: SizedBox(
        width: ScreensHelper.of(context).fromWidth(100),
        child: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
              child: GetPokemon(locator<PokemonUseCase>()).buildPaginationList<PokemonModel>(
                  listBuilder: (PokemonModel data, int index) {
                print('data.image: ${data.image}');
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.0.sp),
                  child: PokemonCard(
                    image: data.image,
                    name: data.name ?? '-',
                  ),
                );
              }, gridBuilder: (PokemonModel data, int index) {
                return const SizedBox();
              })),
        ),
      ),
    );
  }
}
