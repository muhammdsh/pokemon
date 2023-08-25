import 'package:base_structure/app+injection/di.dart';
import 'package:base_structure/core/resources/colors.dart';
import 'package:base_structure/core/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/helper/screen_util/screen_helper.dart';
import '../../../../flows/home_flow/components/custom_button.dart';

extension CustomWidgetExtension on double {
  Widget gap() {
    return SizedBox(height: this);
  }
}

class PaginationError extends StatelessWidget {
  final String error;
  final bool withRetry;
  final VoidCallback? onRetry;
  final bool isPage;

  const PaginationError(
      {super.key, required this.error, this.onRetry, this.withRetry = false, this.isPage = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: !isPage ? ScreensHelper.of(context).fromHeight(70) : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   ImagesKeys.empty,
              //   fit: BoxFit.contain,
              //   height: 200,
              // ),
              ScreenUtil().setVerticalSpacing(200),
              Center(
                  child: Text('SORRY!',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: locator<AppThemeColors>().primaryColor,
                          fontWeight: FontWeight.w700))),
              ScreenUtil().setVerticalSpacing(8),
              Center(
                  child: Text(error.toString().toUpperCase(),
                      style: Theme.of(context).textTheme.bodySmall)),
            ],
          ),
          if (withRetry)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(right: 24.0.sp, left: 24.0.sp, bottom: 20.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Try Again',
                        onPress: () {
                          if (onRetry != null) {
                            onRetry!();
                          }
                        },
                        //spaceBetween: 10,
                        //  icon: SvgPicture.asset(ImagesKeys.logout),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
