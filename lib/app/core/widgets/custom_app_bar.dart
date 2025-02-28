import 'package:flutter/material.dart';
import 'package:mypokedex/app/core/values/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isBackEnabled;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isBackEnabled!,
      title: Text(
        title,
        style: AppTextStyles.titleMedium,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
