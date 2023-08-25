import 'package:base_structure/presentation/flows/home_flow/components/row_shape_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app+injection/di.dart';
import '../../../../core/helper/screen_util/screen_helper.dart';
import '../../../../core/resources/colors.dart';

class AnimatedShape extends StatelessWidget {
  const AnimatedShape({super.key, required this.type});

  final ShapeType type;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: ScreensHelper.of(context).fromWidth(100) - (32.sp * 2),
      height: ScreensHelper.of(context).fromWidth(100) - (32.sp * 2),
      decoration: BoxDecoration(
        color: ShapeMapper.mapShapeToColor(type),
        borderRadius: BorderRadius.circular(ShapeMapper.mapShapeToRadius(type)),
      ),
    );
  }
}

class ShapeMapper {
  static Color mapShapeToColor(ShapeType type) {
    switch (type) {
      case ShapeType.sharpSquare:
        return locator<AppThemeColors>().secondaryColor;
      case ShapeType.roundedSquare:
        return locator<AppThemeColors>().primaryColor;
      case ShapeType.circle:
        return locator<AppThemeColors>().accentRed;
    }
  }

  static double mapShapeToRadius(ShapeType type) {
    switch (type) {
      case ShapeType.sharpSquare:
        return 0;
      case ShapeType.roundedSquare:
        return 48.sp;
      case ShapeType.circle:
        return 211.sp;
    }
  }
}
