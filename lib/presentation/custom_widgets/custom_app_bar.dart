import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app+injection/di.dart';
import '../../core/resources/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: locator<AppThemeColors>().white,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: locator<AppThemeColors>().white),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
