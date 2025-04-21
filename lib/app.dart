import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomme_dapi/bindings/general_bindings.dart';
import 'package:pomme_dapi/routes/app_routes.dart';
import 'package:pomme_dapi/utils/constants/colors.dart';
import 'package:pomme_dapi/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.system, // set thteme mode to system
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      getPages: AppRoutes.page,
      home: const Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}
