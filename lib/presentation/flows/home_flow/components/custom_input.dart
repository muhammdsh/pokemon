import 'package:flutter/material.dart';

import '../../../../app+injection/di.dart';
import '../../../../core/resources/colors.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({super.key, this.hint, required this.onChanged, this.controller});
  final String? hint;
  final void Function(String text) onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hint?? 'Hint',
          hintStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: locator<AppThemeColors>().text),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: locator<AppThemeColors>().text)),
          disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: locator<AppThemeColors>().text)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: locator<AppThemeColors>().text))),
      onChanged: onChanged,
    );
  }
}
