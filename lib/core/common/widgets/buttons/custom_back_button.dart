import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Iconsax.arrow_left_24,
        size: HelperFunctions.screenHeight(context) * 0.03,
        color: AppColors.white,
      ),
      onPressed: () {
        GoRouter.of(context).pop();
      },
    );
  }
}
