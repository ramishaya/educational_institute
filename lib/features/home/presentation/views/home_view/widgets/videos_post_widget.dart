import 'package:educational_institute/core/common/widgets/texts/custom_expandable_text.dart';
import 'package:educational_institute/core/utils/constants/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/features/home/presentation/view_models/dots_cubit.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/widgets/reel_item.dart';

class VideoPostWidget extends StatelessWidget {
  final List<String> videoUrls;
  final String publisher;
  final String content;

  const VideoPostWidget({
    super.key,
    required this.videoUrls,
    required this.publisher,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    final PageController pageController = PageController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: HelperFunctions.screenWidth(context) *
                  AppSizes.horizintalMarginPercent),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 2.0,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    AssetsData.roundedLogo,
                    width: HelperFunctions.screenHeight(context) * 0.05,
                    height: HelperFunctions.screenHeight(context) * 0.05,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: HelperFunctions.screenWidth(context) * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Institute Name',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '1 hour ago',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isDarkMode
                            ? AppColors.softGrey
                            : AppColors.darkerGrey),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: HelperFunctions.screenHeight(context) * 0.01),
        SizedBox(
          height: HelperFunctions.screenHeight(context) * 0.5,
          width: double.infinity,
          child: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                itemCount: videoUrls.length,
                onPageChanged: (index) {
                  BlocProvider.of<DotsCubit>(context).changePage(index);
                },
                itemBuilder: (context, index) {
                  return ReelItem(videoUrl: videoUrls[index]);
                },
              ),
              Positioned(
                top: HelperFunctions.screenHeight(context) * 0.015,
                right: HelperFunctions.screenHeight(context) * 0.015,
                child: BlocBuilder<DotsCubit, int>(
                  builder: (context, state) {
                    return Container(
                      width: HelperFunctions.screenWidth(context) * 0.14,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          '${state + 1}/${videoUrls.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: HelperFunctions.screenHeight(context) * 0.015),
        Center(
          child: BlocBuilder<DotsCubit, int>(
            builder: (context, state) {
              return SmoothPageIndicator(
                controller: pageController,
                count: videoUrls.length,
                effect: const ScrollingDotsEffect(
                  dotWidth: 6.0,
                  dotHeight: 6.0,
                  activeDotColor: AppColors.primaryColor,
                  dotColor: AppColors.darkGrey,
                ),
              );
            },
          ),
        ),
        SizedBox(height: HelperFunctions.screenHeight(context) * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: HelperFunctions.screenWidth(context) *
                  AppSizes.horizintalMarginPercent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomExpandableText(content: content),
            ],
          ),
        ),
      ],
    );
  }
}
