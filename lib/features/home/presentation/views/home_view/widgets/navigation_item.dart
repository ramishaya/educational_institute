import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.labelText,
    required this.icon,
  });
  final String labelText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,
            color: HelperFunctions.isDarkMode(context)
                ? AppColors.black
                : AppColors.white),
        Text(
          labelText,
          style: HelperFunctions.isDarkMode(context)
              ? Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.black)
              : Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.white),
        )
      ],
    );
  }
}
