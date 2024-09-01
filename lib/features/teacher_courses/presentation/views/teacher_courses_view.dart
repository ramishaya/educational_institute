import 'package:flutter/material.dart';
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/assets_data.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class TeacherCoursesView extends StatelessWidget {
  const TeacherCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    const courseTime = "S1 9:00 AM 9:45 AM|S2 9:45 AM 10:30 AM";
    const days = ["MONDAY", "TUESDAY", "THURSDAY"];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Courses",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: HelperFunctions.screenWidth(context) *
                  AppSizes.horizintalMarginPercent,
              bottom: HelperFunctions.screenHeight(context) * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(3, (index) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: HelperFunctions.screenWidth(context) *
                        AppSizes.horizintalMarginPercent,
                    left: HelperFunctions.screenWidth(context) *
                        AppSizes.horizintalMarginPercent,
                    right: HelperFunctions.screenWidth(context) *
                        AppSizes.horizintalMarginPercent),
                child: CourseCard(
                  isDarkMode: isDarkMode,
                  courseTime: courseTime,
                  days: days,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final bool isDarkMode;
  final String courseTime;
  final List<String> days;

  const CourseCard({
    required this.isDarkMode,
    required this.courseTime,
    required this.days,
    super.key,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds:750),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _toggleExpand() {
    setState(() {
      if (_isExpanded) {
        _controller.reverse().then((value) {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        });
      } else {
        _isExpanded = !_isExpanded;
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            child: Stack(
              children: [
                Image.asset(
                  AssetsData.courseCard,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: HelperFunctions.screenHeight(context) * 0.185,
                ),
                Positioned(
                  top: HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent,
                  left: HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent,
                  child: const RatingCircle(
                    initialRating: "B 2.2",
                    newRating: "A 1.1",
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(HelperFunctions.screenWidth(context) * 0.02),
            decoration: BoxDecoration(
              color: widget.isDarkMode ? AppColors.black : AppColors.light,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                HelperFunctions.screenWidth(context) *
                    AppSizes.horizintalMarginPercent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 750),
                  alignment:

                      _isExpanded ? Alignment.center : Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.calendar_1,
                                color: widget.isDarkMode
                                    ? AppColors.grey
                                    : AppColors.darkerGrey,
                              ),
                              SizedBox(
                                width:
                                    HelperFunctions.screenWidth(context) * 0.01,
                              ),
                              Text(
                                "10 January|10 July",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: _toggleExpand,
                            child: Container(
                              width:
                                  HelperFunctions.screenWidth(context) * 0.165,
                              height:
                                  HelperFunctions.screenWidth(context) * 0.165,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 1,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Image.asset(
                                  AssetsData.expandedIcon,
                                  width: HelperFunctions.screenWidth(context) *
                                      0.07,
                                  height: HelperFunctions.screenWidth(context) *
                                      0.07,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                        child: Align(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: _isExpanded
                                ? const BoxConstraints()
                                : const BoxConstraints(maxHeight: 0),
                            child: FadeTransition(
                              opacity: _opacityAnimation,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_isExpanded) ...[
                                    Text(
                                      "Course Time",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 16,
                                            color: widget.isDarkMode
                                                ? AppColors.grey
                                                : AppColors.darkGrey,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: HelperFunctions.screenHeight(
                                              context) *
                                          0.006,
                                    ),
                                    CourseTimes(courseTime: widget.courseTime),
                                    SizedBox(
                                      height: HelperFunctions.screenHeight(
                                              context) *
                                          0.01,
                                    ),
                                    Text(
                                      "Days",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 16,
                                            color: widget.isDarkMode
                                                ? AppColors.grey
                                                : AppColors.darkGrey,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: HelperFunctions.screenHeight(
                                              context) *
                                          0.006,
                                    ),
                                    ScheduleDays(days: widget.days),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseTimes extends StatelessWidget {
  final String courseTime;
  const CourseTimes({required this.courseTime, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(HelperFunctions.screenWidth(context) *
          AppSizes.horizintalMarginPercent /
          2),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        runSpacing: HelperFunctions.screenHeight(context) * 0.005,
        children: [
          Text(
            courseTime,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleDays extends StatelessWidget {
  final List<String> days;
  const ScheduleDays({required this.days, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    const allDays = ["SU", "MO", "TU", "WE", "TH", "FR", "SA"];
    const weekDays = [
      "SUNDAY",
      "MONDAY",
      "TUESDAY",
      "WEDNESDAY",
      "THURSDAY",
      "FRIDAY",
      "SATURDAY"
    ];

    return Wrap(
      spacing: HelperFunctions.screenWidth(context) * 0.013,
      runSpacing: HelperFunctions.screenWidth(context) * 0.005,
      children: allDays.map((day) {
        bool isSelected = days.contains(weekDays[allDays.indexOf(day)]);
        return Container(
          width: HelperFunctions.screenWidth(context) * 0.1,
          height: HelperFunctions.screenWidth(context) * 0.1,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor
                : isDarkMode
                    ? AppColors.darkGrey
                    : AppColors.grey,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class RatingCircle extends StatefulWidget {
  final String initialRating;
  final String newRating;

  const RatingCircle({
    super.key,
    required this.initialRating,
    required this.newRating,
  });

  @override
  State<RatingCircle> createState() => _RatingCircleState();
}

class _RatingCircleState extends State<RatingCircle>
    with SingleTickerProviderStateMixin {
  bool _showInitialRating = true;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _toggleRating() {
    setState(() {
      _showInitialRating = !_showInitialRating;
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleRating,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: Container(
          width: HelperFunctions.screenWidth(context) * 0.165,
          height: HelperFunctions.screenWidth(context) * 0.165,
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Text(
                _showInitialRating
                    ? widget.initialRating.toString()
                    : widget.newRating.toString(),
                key: ValueKey<bool>(_showInitialRating),
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
