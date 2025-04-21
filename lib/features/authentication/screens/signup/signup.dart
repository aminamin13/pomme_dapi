import 'package:flutter/material.dart';
import 'package:pomme_dapi/common/widgets/login_signup/form_divider.dart';
import 'package:pomme_dapi/common/widgets/login_signup/socail_media_login.dart';
import 'package:pomme_dapi/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:pomme_dapi/features/authentication/screens/signup/widgets/signup_header.dart';
import 'package:pomme_dapi/utils/constants/sizes.dart';
import 'package:pomme_dapi/utils/constants/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// logo, title, sibtitle
              SignUpHeader(),
              SignUpForm(),

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
