import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/style/spacing_styles.dart';
import 'package:pomme_dapi/common/widgets/login_signup/form_divider.dart';
import 'package:pomme_dapi/common/widgets/login_signup/socail_media_login.dart';
import 'package:pomme_dapi/features/authentication/screens/login/widgets/login_form.dart';
import 'package:pomme_dapi/features/authentication/screens/login/widgets/login_header.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// logo, title, sibtitle
              LoginHeader(),
              LoginForm(),

              ///Divider
              FormDivider(text: AppTexts.orSignInWith),
              SizedBox(height: AppSizes.spaceBtwItems),
              SocailMediaLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
