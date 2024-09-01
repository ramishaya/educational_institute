import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/core/utils/router/app_router.dart';
import 'package:educational_institute/features/home/presentation/views/course_details/widgets/course_details_header.dart';
import 'package:educational_institute/features/home/presentation/views/course_details/widgets/course_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CourseDetailsView extends StatefulWidget {
  const CourseDetailsView(
      {super.key, required this.image, required this.title, required this.tag});

  final String image, title, tag;

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation1;
  late Animation<Offset> _offsetAnimation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation1 = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start off-screen to the right
      end: const Offset(0.0, 0.0), // End at original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start off-screen at the bottom
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
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseDetailsHeader(tag: widget.tag, image: widget.image),
            SizedBox(
              height: HelperFunctions.screenHeight(context) * 0.006,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CourseInfo(),
                  SizedBox(
                    height: HelperFunctions.screenHeight(context) * 0.03,
                  ),
                  SlideTransition(
                    position: _offsetAnimation1,
                    child: Text(
                      "Deepen Your Mastery with Our B2.1 German Course",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(
                    height: HelperFunctions.screenHeight(context) * 0.02,
                  ),
                  SlideTransition(
                    position: _offsetAnimation2,
                    child: Text(
                      "Elevate your German proficiency with our B2.1 course, tailored for those looking to refine and expand their existing skills. This course delves into complex grammar structures, enriched vocabulary, and more nuanced aspects of conversation and writing. Suitable for intermediate learners who have a solid base in German, you will enhance your ability to argue, discuss, and write with clarity and depth in German. Explore culturally rich content and interactive lessons that challenge you to think critically and communicate effectively in real-world scenarios.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    height: HelperFunctions.screenHeight(context) * 0.04,
                  ),
                  Center(
                    child: SlideAction(
                      sliderButtonIconPadding: 20,
                      sliderButtonIconSize: 20,
                      elevation: 4,
                      outerColor: AppColors.primaryColor,
                      innerColor: isDarkMode
                          ? AppColors.darkPrimaryColor
                          : AppColors.darkPrimaryColor,
                      sliderButtonIcon: const Icon(
                        color: AppColors.white,
                        Icons.arrow_circle_right,
                        size: 30,
                      ),
                      text: "Slide to Book",
                      animationDuration: const Duration(milliseconds: 500),
                      submittedIcon: const CircularProgressIndicator(
                        backgroundColor: AppColors.white,
                        color: AppColors.primaryColor,
                      ),
                      onSubmit: () {
                        GoRouter.of(context).push(AppRouter.kPlacementTestView);
                        return;
                      },
                    ),
                  ),
                  SizedBox(
                    height: HelperFunctions.screenHeight(context) * 0.04,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
