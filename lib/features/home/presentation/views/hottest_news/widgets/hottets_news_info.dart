import 'package:educational_institute/core/common/widgets/containers/rounded_thin_container.dart';
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/assets_data.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HottestNewsInfo extends StatefulWidget {
  const HottestNewsInfo({
    super.key,
  });

  @override
  State<HottestNewsInfo> createState() => _HottestNewsInfoState();
}

class _HottestNewsInfoState extends State<HottestNewsInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start off-screen to the right
      end: const Offset(0.0, 0.0), // End at original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SlideTransition(
          position: _offsetAnimation,
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
        ),
        SlideTransition(
          position: _offsetAnimation,
          child: RoundedThinContainer(
              backGroundColor: isDarkMode ? AppColors.grey : AppColors.softGrey,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: AppSizes.borderRadiusLg,
                  child: Icon(
                    Iconsax.calendar_1,
                    color: isDarkMode ? AppColors.darkGrey : AppColors.darkGrey,
                  ),
                ),
                SizedBox(
                  width: HelperFunctions.screenWidth(context) * 0.02,
                ),
                Text(
                  "jun 12, 2024",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: isDarkMode
                            ? AppColors.darkGrey
                            : AppColors.darkGrey,
                      ),
                )
              ]),
        )
      ],
    );
  }
}
