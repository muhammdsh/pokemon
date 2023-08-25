import 'package:base_structure/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app+injection/di.dart';
import '../../../../core/helper/screen_util/screen_helper.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.backgroundColor, required this.text, required this.onPress});

  final Color? backgroundColor;
  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreensHelper.of(context).fromWidth(100),
      height: 57.sp,
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp))),
            backgroundColor: MaterialStateProperty.all(
                backgroundColor ?? locator<AppThemeColors>().secondaryColor)),
        onPressed: onPress,
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: locator<AppThemeColors>().white)),
      ),
    );
  }
}
