import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:educational_institute/core/utils/local_storage/local_storage.dart';
import 'package:educational_institute/features/calender/presentation/views/calendar_view/calendar_view.dart';
import 'package:educational_institute/features/teacher_courses/presentation/views/teacher_courses_view.dart';
import 'package:educational_institute/features/home/presentation/views/home_view/home_view.dart';
import 'package:educational_institute/features/pleacment_test/presentation/views/pleacment_test/pleacment_test.dart';
import 'package:educational_institute/features/profile/presentation/profile_placeholder_view.dart';
import 'package:educational_institute/features/profile/presentation/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({
    super.key,
  });

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  int currentIndex = 0;
  late AnimationController idleAnimationController;
  late AnimationController onSelectedAnimationController;
  late AnimationController onChangedAnimationController;

  @override
  void initState() {
    super.initState();
    idleAnimationController = AnimationController(vsync: this);
    onSelectedAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    onChangedAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    _pageController.dispose();
    idleAnimationController.dispose();
    onSelectedAnimationController.dispose();
    onChangedAnimationController.dispose();
    super.dispose();
  }

  void updateIndex(int index) {
    onSelectedAnimationController.reset();
    onSelectedAnimationController.forward();
    onChangedAnimationController.value = 1;
    onChangedAnimationController.reverse();
    setState(() {
      currentIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    final bool isGuest = LocalStorage.getData(key: 'isGuest');

    List<BottomBarItem> guestBottomBarItems = [
      BottomBarItem(
          inActiveItem: Column(
            children: [
              Lottie.asset(
                isDarkMode
                    ? "assets/images/unselectedhome.json"
                    : "assets/images/lighthomeicon.json",
                controller: currentIndex == 0
                    ? onSelectedAnimationController
                    : currentIndex == 0
                        ? onChangedAnimationController
                        : idleAnimationController,
                alignment: Alignment.center,
                animate: true,
              ),
            ],
          ),
          activeItem: Center(
            child: Lottie.asset(
              fit: BoxFit.cover,
              "assets/images/home.json",
              controller: currentIndex == 0
                  ? onSelectedAnimationController
                  : currentIndex == 0
                      ? onChangedAnimationController
                      : idleAnimationController,
              alignment: Alignment.center,
              animate: true,
            ),
          ),
          itemLabel: "Home"),
      BottomBarItem(
        inActiveItem: Lottie.asset(
          isDarkMode
              ? "assets/images/unselectedbook.json"
              : "assets/images/lightbookicon.json",
          controller: currentIndex == 1
              ? onSelectedAnimationController
              : currentIndex == 1
                  ? onChangedAnimationController
                  : idleAnimationController,
          alignment: Alignment.center,
          animate: true,
        ),
        activeItem: Center(
          child: Lottie.asset(
            "assets/images/selectedbook.json",
            controller: currentIndex == 1
                ? onSelectedAnimationController
                : currentIndex == 1
                    ? onChangedAnimationController
                    : idleAnimationController,
            alignment: Alignment.center,
            animate: true,
          ),
        ),
        itemLabel: 'Test',
      ),
      BottomBarItem(
        inActiveItem: Lottie.asset(
          isDarkMode
              ? "assets/images/unselecteduser.json"
              : "assets/images/lightusericon.json",
          controller: currentIndex == 2
              ? onSelectedAnimationController
              : currentIndex == 2
                  ? onChangedAnimationController
                  : idleAnimationController,
          alignment: Alignment.center,
          animate: true,
        ),
        activeItem: Center(
            child: Lottie.asset(
          "assets/images/user.json",
          controller: currentIndex == 2
              ? onSelectedAnimationController
              : currentIndex == 2
                  ? onChangedAnimationController
                  : idleAnimationController,
          alignment: Alignment.center,
          animate: true,
        )),
        itemLabel: 'User',
      ),
    ];

    List<BottomBarItem> teacherBottomBarItems = [
      BottomBarItem(
          inActiveItem: Column(
            children: [
              Lottie.asset(
                isDarkMode
                    ? "assets/images/unselectedhome.json"
                    : "assets/images/lighthomeicon.json",
                controller: currentIndex == 0
                    ? onSelectedAnimationController
                    : currentIndex == 0
                        ? onChangedAnimationController
                        : idleAnimationController,
                alignment: Alignment.center,
                animate: true,
              ),
            ],
          ),
          activeItem: Center(
            child: Lottie.asset(
              fit: BoxFit.cover,
              "assets/images/home.json",
              controller: currentIndex == 0
                  ? onSelectedAnimationController
                  : currentIndex == 0
                      ? onChangedAnimationController
                      : idleAnimationController,
              alignment: Alignment.center,
              animate: true,
            ),
          ),
          itemLabel: "Home"),
      BottomBarItem(
          inActiveItem: Lottie.asset(
            isDarkMode
                ? "assets/images/unselectedlightcourse.json"
                : "assets/images/unselectedcourse.json",
            controller: currentIndex == 1
                ? onSelectedAnimationController
                : currentIndex == 1
                    ? onChangedAnimationController
                    : idleAnimationController,
            alignment: Alignment.center,
            animate: true,
          ),
          activeItem: Center(
            child: Lottie.asset(
              fit: BoxFit.cover,
              "assets/images/secourse.json",
              controller: currentIndex == 1
                  ? onSelectedAnimationController
                  : currentIndex == 1
                      ? onChangedAnimationController
                      : idleAnimationController,
              alignment: Alignment.center,
              animate: true,
            ),
          ),
          itemLabel: "Course"),
      BottomBarItem(
          inActiveItem: Lottie.asset(
            isDarkMode
                ? "assets/images/unselectedcalender.json"
                : "assets/images/unselectedcalender.json",
            controller: currentIndex == 2
                ? onSelectedAnimationController
                : currentIndex == 2
                    ? onChangedAnimationController
                    : idleAnimationController,
            alignment: Alignment.center,
            animate: true,
          ),
          activeItem: Lottie.asset(
            "assets/images/secalender.json",
            controller: currentIndex == 2
                ? onSelectedAnimationController
                : currentIndex == 2
                    ? onChangedAnimationController
                    : idleAnimationController,
            alignment: Alignment.center,
            animate: true,
          ),
          itemLabel: "Calender"),
      BottomBarItem(
        inActiveItem: Lottie.asset(
          isDarkMode
              ? "assets/images/unselectedbook.json"
              : "assets/images/lightbookicon.json",
          controller: currentIndex == 3
              ? onSelectedAnimationController
              : currentIndex == 3
                  ? onChangedAnimationController
                  : idleAnimationController,
          alignment: Alignment.center,
          animate: true,
        ),
        activeItem: Center(
          child: Lottie.asset(
            "assets/images/selectedbook.json",
            controller: currentIndex == 3
                ? onSelectedAnimationController
                : currentIndex == 3
                    ? onChangedAnimationController
                    : idleAnimationController,
            alignment: Alignment.center,
            animate: true,
          ),
        ),
        itemLabel: 'Test',
      ),
      BottomBarItem(
        inActiveItem: Lottie.asset(
          isDarkMode
              ? "assets/images/unselecteduser.json"
              : "assets/images/lightusericon.json",
          controller: currentIndex == 4
              ? onSelectedAnimationController
              : currentIndex == 4
                  ? onChangedAnimationController
                  : idleAnimationController,
          alignment: Alignment.center,
          animate: true,
        ),
        activeItem: Center(
            child: Lottie.asset(
          "assets/images/user.json",
          controller: currentIndex == 4
              ? onSelectedAnimationController
              : currentIndex == 4
                  ? onChangedAnimationController
                  : idleAnimationController,
          alignment: Alignment.center,
          animate: true,
        )),
        itemLabel: 'User',
      ),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: isGuest ? guestScreens : teacherScreens,
      ),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: HelperFunctions.screenHeight(context) * 0.112,
        width: double.infinity,
        child: AnimatedNotchBottomBar(
          shadowElevation: 5.0,
          elevation: 1.0,
          showShadow: true,
          durationInMilliSeconds: 350,
          textAlign: TextAlign.center,
          textOverflow: TextOverflow.ellipsis,
          notchBottomBarController: _controller,
          removeMargins: true,
          kBottomRadius: 0,
          showTopRadius: true,
          showBottomRadius: false,
          bottomBarWidth: double.infinity,
          maxLine: 1,
          kIconSize: HelperFunctions.screenHeight(context) * 0.035,
          bottomBarHeight: HelperFunctions.screenHeight(context) * 0.02,
          circleMargin: isGuest
              ? HelperFunctions.screenHeight(context) * 0.019
              : HelperFunctions.screenHeight(context) * 0.008,
          topMargin: isGuest
              ? HelperFunctions.screenHeight(context) * 0.019
              : HelperFunctions.screenHeight(context) * 0.018,
          itemLabelStyle: isDarkMode
              ? Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)
              : Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
          color: isDarkMode ? AppColors.dark : AppColors.white,
          showLabel: true,
          notchColor: isDarkMode ? AppColors.dark : AppColors.white,
          bottomBarItems: isGuest ? guestBottomBarItems : teacherBottomBarItems,
          onTap: updateIndex,
        ),
      ),
    );
  }
}

final List<Widget> guestScreens = [
  const HomeView(),
  const PlacementTest(),
  const ProfilePlaceholderView(),
];

final List<Widget> teacherScreens = [
  const HomeView(),
  const TeacherCoursesView(),
  const CalenderView(),
  const PlacementTest(),
  const ProfileView(),
];
