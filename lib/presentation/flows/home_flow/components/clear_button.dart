import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app+injection/di.dart';
import '../../../../core/resources/colors.dart';
import '../../../../core/resources/constants.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({super.key, required this.onClear});

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.sp,
      child: TextButton(
          onPressed: onClear,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(ImagesKeys.clear),
              Text('Clear Text',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: locator<AppThemeColors>().error))
            ],
          )),
    );
  }
}
