
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class CircularBackButton extends StatelessWidget {
  const CircularBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: HelperFunctions.screenHeight(context) * 0.03,
      backgroundColor: AppColors.white,
      child: Center(
        child: IconButton(
          icon: Icon(
            Iconsax.arrow_left_24,
            size:
                HelperFunctions.screenHeight(context) * 0.03,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
    );
  }
}
