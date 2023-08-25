import 'dart:io';

import 'package:base_structure/app+injection/di.dart';
import 'package:base_structure/core/helper/screen_util/screen_helper.dart';
import 'package:base_structure/core/navigation/routes.dart';
import 'package:base_structure/core/resources/colors.dart';
import 'package:base_structure/core/resources/constants.dart';
import 'package:base_structure/presentation/flows/home_flow/bloc/home_bloc.dart';
import 'package:base_structure/presentation/flows/home_flow/components/clear_button.dart';
import 'package:base_structure/presentation/flows/home_flow/components/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../components/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final bloc = locator<HomeBloc>();
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    // bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0.sp,
        centerTitle: false,
        title: Text(
          'Home',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: locator<AppThemeColors>().white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
          child: Column(
            children: [
              ScreenUtil().setVerticalSpacing(40),
              BlocBuilder<HomeBloc, HomeState>(
                bloc: bloc,
                builder: (context, state) {
                  return Column(
                    children: [
                      CustomInput(
                        controller: controller,
                        hint: 'Enter your name',
                        onChanged: (String text) {
                          bloc.onTextChangedAction(text);
                        },
                      ),
                      ScreenUtil().setVerticalSpacing(40),
                      Text(state.text,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: locator<AppThemeColors>().black)),
                    ],
                  );
                },
              ),
              const Spacer(),
              ClearButton(
                onClear: () {
                  controller.clear();
                  bloc.onClearAction();
                },
              ),
              ScreenUtil().setVerticalSpacing(10),
              CustomButton(
                text: 'Go to page 1',
                onPress: () {
                  context.push(RoutesPath.animationPage);
                },
              ),
              ScreenUtil().setVerticalSpacing(20),
              CustomButton(
                text: 'Go to page 2',
                onPress: () {
                  context.push(RoutesPath.pokemonPage);
                },
                backgroundColor: locator<AppThemeColors>().primaryColor,
              ),
              if(Platform.isAndroid)
                ScreenUtil().setVerticalSpacing(30)
            ],
          ),
        ),
      ),
    );
  }
}
