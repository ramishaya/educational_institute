import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/core/utils/router/app_router.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/teacher_info_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourseCard extends StatelessWidget {
  final String image;
  final String logo;
  final String title;
  final String description;
  final String buttonText;

  const CourseCard({
    super.key,
    required this.image,
    required this.logo,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: HelperFunctions.screenWidth(context) *
            AppSizes.horizintalMarginPercent,
      ),
      child: Card(
        color: isDarkMode ? AppColors.dark : AppColors.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
        ),
        elevation: 5,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.cardRadiusLg),
                    topRight: Radius.circular(AppSizes.cardRadiusLg),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: HelperFunctions.screenHeight(context) * 0.35,
                  ),
                ),
                Hero(
                  tag: title,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.cardRadiusLg),
                      topRight: Radius.circular(AppSizes.cardRadiusLg),
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: HelperFunctions.screenHeight(context) * 0.30,
                    ),
                  ),
                ),
                Positioned(
                  top: HelperFunctions.screenHeight(context) * 0.27,
                  left: HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent,
                  child: Card(
                    elevation: 4,
                    child: Container(
                      width: HelperFunctions.screenWidth(context) * 0.3,
                      height: HelperFunctions.screenHeight(context) * 0.055,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white),
                      child: Image.asset(
                        logo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent,
                  right: HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent,
                  bottom: HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                      height: HelperFunctions.screenHeight(context) * 0.01),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                      height: HelperFunctions.screenHeight(context) * 0.02),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kCourseDetailsView,
                            extra: Tranobj(title, tag: title, image: image));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppSizes.cardRadiusLg))),
                      child: Text(buttonText),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
