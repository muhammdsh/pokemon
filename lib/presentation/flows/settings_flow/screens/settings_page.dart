import 'package:base_structure/app+injection/di.dart';
import 'package:base_structure/core/localization/app_lang.dart';
import 'package:base_structure/core/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:base_structure/core/blocs/application_bloc/app_bloc.dart';
import 'package:base_structure/core/resources/constants.dart';
import 'package:base_structure/presentation/custom_widgets/text_translation.dart';

enum Degree { c, f }

enum Wind { ms, kmh }

enum Pressure { mmHg, hPa }

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key}) ;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool switcher = true;
  String selectedTheme = "Light";

  final language = {
    AppLanguages.en: TextTranslation(TranslationsKeys.english),
    AppLanguages.ar: TextTranslation(TranslationsKeys.arabic)
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        //   print(' locator<exchangeBloc>().state.unit: ${ locator<ExchangeBloc>().state.unit}');

        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                // leadingWidth: ScreensHelper.fromWidth(100) ,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextTranslation(TranslationsKeys.settings,
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                backgroundColor: locator<AppThemeColors>().backgroundColor,
                //title: ,
                pinned: true,
                elevation: 0,
                leading: const SizedBox(),
                leadingWidth: 0,
                centerTitle: false,
                // leading: SizedBox(),
              )
            ];
          },
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  color: locator<AppThemeColors>().surface,
                  height: 190.sp,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.sp, vertical: 8.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomSegmentedControlRow<AppLanguages>(
                          title: TranslationsKeys.changeLanguage.tr(context),
                          onValueChanged: (value) {
                            print('ssssss: $value');
                            locator<AppBloc>().changeLanguage(value);

                            //  setState(() {});
                          },
                          groupValue: locator<AppBloc>().state.language,
                          children: language,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextTranslation(
                              TranslationsKeys.changeTheme,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              children: [
                                PullDownButton(
                                  position: PullDownMenuPosition.over,
                                  itemBuilder: (context) => [
                                    PullDownMenuItem.selectable(
                                      title: TranslationsKeys.light.tr(context),
                                      icon: CupertinoIcons.sun_max_fill,
                                      iconColor: Colors.amber,
                                      selected: state.appThemeMode != AppThemeMode.dark,
                                      onTap: () {
                                        selectedTheme = TranslationsKeys.light.tr(context);
                                        locator<AppBloc>()
                                            .changeTheme(appThemeMode: AppThemeMode.light);
                                      },
                                    ),
                                    PullDownMenuItem.selectable(
                                      title: TranslationsKeys.dark.tr(context),
                                      icon: CupertinoIcons.moon_fill,
                                      iconColor: Colors.deepPurpleAccent,
                                      selected: state.appThemeMode == AppThemeMode.dark,
                                      onTap: () {
                                        selectedTheme = TranslationsKeys.dark.tr(context);
                                        locator<AppBloc>()
                                            .changeTheme(appThemeMode: AppThemeMode.dark);
                                      },
                                    ),
                                  ],
                                  buttonBuilder: (context, showMenu) => CupertinoButton(
                                    onPressed: showMenu,
                                    padding: EdgeInsets.zero,
                                    child: TextTranslation(
                                      state.appThemeMode == AppThemeMode.dark
                                          ? TranslationsKeys.dark
                                          : TranslationsKeys.light,
                                      style: TextStyle(
                                          color: locator<AppThemeColors>().primaryColor400),
                                    ),
                                  ),
                                ),
                                ScreenUtil().setHorizontalSpacing(12)
                              ],
                            ),
                            // SizedBox(width: 2,)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextTranslation(
                              TranslationsKeys.showDetails,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 45.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0.sp),
                                    border:
                                        Border.all(color: locator<AppThemeColors>().secondaryColor),
                                    //  color: locator<AppThemeColors>().secondaryColor,
                                  ),
                                  child: CupertinoSwitch(
                                      activeColor: locator<AppThemeColors>().secondaryColor,
                                      value: switcher,
                                      onChanged: (value) {
                                        switcher = value;
                                        setState(() {});
                                      }),
                                ),
                                ScreenUtil().setHorizontalSpacing(12),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        );
      },
    );
  }
}

class CustomSegmentedControlRow<T extends Object> extends StatefulWidget {
  const CustomSegmentedControlRow({
    super.key,
    required this.title,
    required this.children,
    required this.groupValue,
    required this.onValueChanged,
  }) ;

  final String title;
  final Map<T, Widget> children;
  final T? groupValue;
  final ValueChanged<T> onValueChanged;

  @override
  _CustomSegmentedControlRowState<T> createState() => _CustomSegmentedControlRowState<T>();
}

class _CustomSegmentedControlRowState<T extends Object> extends State<CustomSegmentedControlRow<T>> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          //  width: 240.sp,
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: CupertinoSegmentedControl(
            selectedColor: locator<AppThemeColors>().secondaryColor,
            unselectedColor: locator<AppThemeColors>().white,
            borderColor: locator<AppThemeColors>().secondaryColor,
            children: widget.children,
            groupValue: widget.groupValue,
            onValueChanged: widget.onValueChanged,
          ),
        ),
      ],
    );
  }
}
