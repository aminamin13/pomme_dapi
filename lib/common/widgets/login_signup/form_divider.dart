import 'package:flutter/material.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            thickness: 2.5,
            indent: 60,
            endIndent: 10,
            color: dark ? AppColors.darkGrey : AppColors.grey,
          ),
        ),
        Text(text, style: Theme.of(context).textTheme.labelMedium),
        Flexible(
          child: Divider(
            thickness: 2.5,
            indent: 10,
            endIndent: 60,
            color: dark ? AppColors.darkGrey : AppColors.grey,
          ),
        ),
      ],
    );
  }
}
