import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';
import 'package:mypokedex/app/core/widgets/custom_app_bar.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'About'),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "This app is a simple Pokedex app built with Flutter and GetX. It uses the PokeAPI to fetch data. It's a project for technical interview test purposes.\n\nAuthor: Suhendra",
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ),
    );
  }
}
