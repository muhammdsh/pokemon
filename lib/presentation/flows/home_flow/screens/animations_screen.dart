import 'package:base_structure/core/helper/screen_util/screen_helper.dart';
import 'package:base_structure/presentation/flows/home_flow/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../app+injection/di.dart';
import '../../../../core/resources/colors.dart';
import '../../../custom_widgets/custom_app_bar.dart';
import '../bloc/animation/animation_cubit.dart';
import '../components/animated_shape.dart';
import '../components/row_shape_types.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  final bloc = locator<HomeBloc>();
  final animationCubit = locator<AnimationCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Animations'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.sp),
          child: SizedBox(
            width: ScreensHelper.of(context).fromWidth(100),
            child: Column(
              children: [
                ScreenUtil().setVerticalSpacing(40),
                BlocBuilder<HomeBloc, HomeState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return Text(state.text,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: locator<AppThemeColors>().black));
                  },
                ),
                ScreenUtil().setVerticalSpacing(60),
                BlocBuilder<AnimationCubit, AnimationState>(
                  bloc: animationCubit,
                  builder: (context, state) {
                    return AnimatedShape(
                      type: state.type,
                    );
                  },
                ),
                const Spacer(),
                RowShapeType(
                  selectedType: (ShapeType type) {
                    animationCubit.changeShapeType(type);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
