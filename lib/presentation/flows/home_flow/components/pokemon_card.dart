import 'package:base_structure/app+injection/di.dart';
import 'package:base_structure/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/screen_util/screen_helper.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.image, required this.name});

  final String? image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreensHelper.of(context).fromWidth(100),
      height: 128.sp,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.sp),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: image != null
                      ? Image.network(image!)
                      : Container(
                          color: locator<AppThemeColors>().grey,
                          child: const Center(
                            child: Icon(Icons.image_outlined),
                          ),
                        ))),
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 16.sp),
                child: Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: locator<AppThemeColors>().black),
                ),
              ))
        ],
      ),
    );
  }
}
