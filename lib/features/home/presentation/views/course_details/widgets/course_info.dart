import 'package:educational_institute/core/common/widgets/containers/rounded_thin_container.dart';
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/assets_data.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CourseInfo extends StatelessWidget {
  const CourseInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: HelperFunctions.screenWidth(context) * 0.45,
      child: RoundedThinContainer(
          backGroundColor: AppColors.primaryColor,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.white,
              radius: AppSizes.borderRadiusLg,
              child: Image.asset(
                fit: BoxFit.cover,
                AssetsData.nameLogo,
              ),
            ),
            SizedBox(
              width: HelperFunctions.screenWidth(context) * 0.02,
            ),
            Text(
              "Institute Name",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.white),
            )
          ]),
    );
  }
}
