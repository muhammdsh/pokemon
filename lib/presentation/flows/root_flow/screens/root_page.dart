import 'package:flutter/material.dart';

enum RootTabs { currency, converter, gold, settings }



class RootPageWidget extends StatefulWidget {
  const RootPageWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RootPageWidgetState createState() => _RootPageWidgetState();
}

class _RootPageWidgetState extends State<RootPageWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

/// CurvedNavigationBar Example
/*
 CurvedNavigationBar(
            color: locator<AppThemeColors>().primaryColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // height: 75.sp,
            items: <NavBarItem>[
              NavBarItem(
                  widget: SvgPicture.asset(
                    ImagesKeys.rain,
                  ),
                  name: "Currency".tr(context)),
              NavBarItem(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImagesKeys.rain3,
                    ),
                  ),
                  name: "Converter".tr(context)),
              NavBarItem(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImagesKeys.rain1,
                    ),
                  ),
                  name: "Gold".tr(context)),
              NavBarItem(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImagesKeys.rain2,
                    ),
                  ),
                  name: "settings".tr(context)),
            ],
            onTap: (index) {
              //Handle button tap
              bloc.navigateTo(RootTabs.values[index]);
            },
          ),
 */
