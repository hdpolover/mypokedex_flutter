import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mypokedex/app/core/values/app_colors.dart';
import 'package:mypokedex/app/core/values/app_strings.dart';
import 'package:mypokedex/app/core/widgets/poke_loading.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/pokeball.png",
                    height: Get.height * 0.15,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppStrings.appName,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: PokeLoading(
              isSmall: true,
              isWhite: true,
            ),
          ),
        ],
      ),
    );
  }
}
