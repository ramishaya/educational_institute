import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Map<String, String> event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Card(
      color: isDarkMode ? AppColors.dark : AppColors.light,
      elevation: 4,
      margin: EdgeInsets.symmetric(
          vertical: HelperFunctions.screenWidth(context) *
              AppSizes.horizintalMarginPercent),
      child: Padding(
        padding: EdgeInsets.all(HelperFunctions.screenWidth(context) *
            AppSizes.horizintalMarginPercent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.circle_outlined,
                  color: AppColors.primaryColor,
                  size: 13,
                ),
                SizedBox(width: HelperFunctions.screenWidth(context) * 0.02),
                Text(
                  event["time"]!,
                  style: TextStyle(
                      color:
                          isDarkMode ? AppColors.softGrey : AppColors.darkGrey),
                ),
              ],
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.006),
            Text(
              event["title"]!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.006),
            Text(
              event["description"]!,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
