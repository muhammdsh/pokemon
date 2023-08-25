import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app+injection/di.dart';
import '../../../../core/resources/colors.dart';

enum ShapeType { sharpSquare, roundedSquare, circle }

class RowShapeType extends StatelessWidget {
  const RowShapeType({super.key, required this.selectedType});

  final void Function(ShapeType type) selectedType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              selectedType(ShapeType.sharpSquare);
            },
            child: ShapeTypeWidget(
              color: locator<AppThemeColors>().secondaryColor,
            )),
        InkWell(
          borderRadius: BorderRadius.circular(15.sp),
            onTap: () {
              selectedType(ShapeType.roundedSquare);
            },
            child: ShapeTypeWidget(
              color: locator<AppThemeColors>().primaryColor,
              borderRadius: 15.sp,
            )),
        InkWell(
            borderRadius: BorderRadius.circular(211.sp),

            onTap: () {
              selectedType(ShapeType.circle);
            },
            child: ShapeTypeWidget(
              color: locator<AppThemeColors>().accentRed,
              borderRadius: 211.sp,
            ))
      ],
    );
  }
}

class ShapeTypeWidget extends StatelessWidget {
  const ShapeTypeWidget({super.key, required this.color, this.borderRadius});

  final Color color;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 70.sp,
      height: 70.sp,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
    );
  }
}
