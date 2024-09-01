import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/constants/texts.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: HelperFunctions.screenWidth(context) *
              AppSizes.horizintalMarginPercent),
      child: Container(
        height: HelperFunctions.screenHeight(context) * 0.065,
        width: HelperFunctions.screenWidth(context) * 0.5,
        padding: const EdgeInsets.all(0.8),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd)),
        child: Center(
          child: Text(
            AppTexts.homeTitle1,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
