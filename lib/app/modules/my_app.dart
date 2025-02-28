import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypokedex/app/core/values/app_strings.dart';

import '../bindings/initial_bindings.dart';
import '../core/values/app_theme.dart';
import '../routes/app_pages.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      initialRoute: AppPages.INITIAL,
      initialBinding: InitialBinding(),
      getPages: AppPages.routes,
      theme: AppTheme.appMainTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
