
import 'package:base_structure/core/localization/app_lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/constants.dart';
import '../../../home_flow/screens/home_screen.dart';
import '../../../settings_flow/screens/settings_page.dart';

class NavigationItem {
  final String title;
  final String? enabledIcon;
  final String? disabledIcon;
  final Widget page;

  NavigationItem({required this.title, this.enabledIcon, this.disabledIcon, required this.page});
}

class NavigationController {
  ///TODO Change Scaffold with your page and title with page name
  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      title: TranslationsKeys.myLocation,
      page: HomeScreen(),
    ),
    NavigationItem(
      title: "title",
      page: const Scaffold(),
    ),
    NavigationItem(
      title: "title",
      page: const Scaffold(),
    ),
    NavigationItem(
      title: "title",
      page: SettingsPage(),
    ),
  ];

  NavigationItem currentNavigationItem(index) => _navigationItems[index];

  List<BottomNavigationBarItem> bottomNavigationBarItems(context) => _navigationItems
      .map((item) => BottomNavigationBarItem(
    icon: SvgPicture.asset(item.disabledIcon ?? item.enabledIcon!),
    activeIcon: SvgPicture.asset(item.enabledIcon ?? item.disabledIcon!),
    label: item.title.tr(context),
  ))
      .toList();
}
