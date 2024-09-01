import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/assets_data.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/core/utils/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePlaceholderView extends StatelessWidget {
  const ProfilePlaceholderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: HelperFunctions.screenWidth(context) *
                AppSizes.horizintalMarginPercent *
                1,
            vertical: HelperFunctions.screenHeight(context) * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                child: Image.asset(
                  AssetsData.roundedLogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.03),
            Text(
              'To view or edit your profile, you need to be logged in.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.02),
            Text(
              'Being a registered user allows you to personalize your experience, track your activities, and engage more deeply with our community.\nThank you for visiting our App',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.05),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kLoginView);
                  },
                  child: const Text("Join")),
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.03),
            Align(
              alignment: Alignment.center,
              child: Text(
                "We're looking forward to seeing your profile!",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
