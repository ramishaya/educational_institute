import 'package:countries_flag/countries_flag.dart';
import 'package:educational_institute/core/common/widgets/buttons/custom_back_button.dart';
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/assets_data.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/constants/texts.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/features/home/presentation/view_models/dots_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TeacherDetails extends StatefulWidget {
  final String heroTag;
  final String image;

  const TeacherDetails({super.key, required this.heroTag, required this.image});

  @override
  State<TeacherDetails> createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;
  late Animation<Offset> _animation3;
  late Animation<Offset> _animation4; // New animation for the Syrian text
  late Animation<Offset>
      _animationCherryPost; // New animation for the Cherry Post
  late Animation<double> _fadeAnimation;
  late PageController _pageController;

  final List<String> _images = [
    AssetsData.card1,
    AssetsData.card2,
    AssetsData.card3,
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _pageController = PageController();

    _animation1 = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _animation2 = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.2,
        1.0,
        curve: Curves.easeOut,
      ),
    ));

    _animation4 = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.3,
        1.0,
        curve: Curves.easeOut,
      ),
    ));

    _animation3 = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.4,
        1.0,
        curve: Curves.easeOut,
      ),
    ));

    _animationCherryPost = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.easeOut,
      ),
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.4,
        1.0,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppTexts.teacherCv,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.white),
        ),
        leading: CustomBackButton(isDarkMode: isDarkMode),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(HelperFunctions.screenWidth(context) *
              AppSizes.horizintalMarginPercent),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                _buildProfileCard(context, isDarkMode),
                SizedBox(height: HelperFunctions.screenHeight(context) * 0.01),
                _buildAnimatedCherryPostCard(context, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, bool isDarkMode) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: isDarkMode ? AppColors.black : AppColors.white,
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(HelperFunctions.screenWidth(context) *
            AppSizes.horizintalMarginPercent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: widget.heroTag,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 3.0,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    widget.image,
                    width: HelperFunctions.screenHeight(context) * 0.13,
                    height: HelperFunctions.screenHeight(context) * 0.13,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.01),
            SlideTransition(
              position: _animation1,
              child: Text(
                'F. Ferina Ch',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.003),
            SlideTransition(
              position: _animation2,
              child: Text(
                'English Teacher',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color:
                        isDarkMode ? AppColors.softGrey : AppColors.darkerGrey),
              ),
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.003),
            SlideTransition(
              position: _animation4,
              child: Row(
                children: [
                  Text(
                    'Syrian',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: isDarkMode
                            ? AppColors.softGrey
                            : AppColors.darkerGrey),
                  ),
                  SizedBox(width: HelperFunctions.screenWidth(context) * 0.015),
                  CountriesFlag(Flags.syria, height: 24), // Syrian flag
                ],
              ),
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.003),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _animation3,
                child: Text(
                  "Passionate English teacher with over 5 years of experience in creating engaging and dynamic curriculum for high school and adult learners at XYZ International School.Specialized in ESL education, holding a TEFL certification and a Master's degree in English Literature from University of ABC.",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCherryPostCard(BuildContext context, bool isDarkMode) {
    return SlideTransition(
      position: _animationCherryPost,
      child: _buildCherryPostCard(context, isDarkMode),
    );
  }

  Widget _buildCherryPostCard(BuildContext context, bool isDarkMode) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: isDarkMode ? AppColors.black : AppColors.white,
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(HelperFunctions.screenWidth(context) *
            AppSizes.horizintalMarginPercent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
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
                      widget.image,
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
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.01),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: SizedBox(
                  height: HelperFunctions.screenHeight(context) * 0.3,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _images.length,
                    onPageChanged: (index) {
                      BlocProvider.of<DotsCubit>(context).changePage(index);
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _images[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.01),
            Center(
              child: BlocBuilder<DotsCubit, int>(
                builder: (context, state) {
                  return SmoothPageIndicator(
                    controller: _pageController,
                    count: _images.length,
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
            Text(
              'Look at Mr.xxxx newest news',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: HelperFunctions.screenHeight(context) * 0.003),
            Text(
              'We are so excited to tell you what happend with us this week!.',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
            ),
          ],
        ),
      ),
    );
  }
}
