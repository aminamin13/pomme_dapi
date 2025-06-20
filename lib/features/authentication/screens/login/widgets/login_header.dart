import 'package:flutter/material.dart';
import 'package:pomme_dapi/utils/constants/image_strings.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/constants/text_strings.dart';
import 'package:pomme_dapi/utils/helpers/helper_functions.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(
            dark ? AppImages.lightAppLogo : AppImages.darkAppLogo,
          ),
        ),
        Text(
          AppTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          AppTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
