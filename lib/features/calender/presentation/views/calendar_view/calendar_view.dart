import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/router/app_router.dart';
import 'package:educational_institute/features/calender/presentation/view_models/year_month_picker_cubit/year_month_picker_cubit.dart';
import 'package:educational_institute/features/calender/presentation/views/calendar_view/widgets/calender_header.dart';
import 'package:educational_institute/features/calender/presentation/views/calendar_view/widgets/event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<Map<String, String>>> _events = {
    DateTime(2024, 7, 3): [
      {
        "time": "08:30~09:30",
        "title": "Work morning",
        "description": "According to the future tasks and hello my name is rami"
      },
      {
        "time": "14:30~16:00",
        "title": "Work report",
        "description": "Reviewing the quarterly reports and..."
      }
    ],
    DateTime(2024, 7, 4): [
      {
        "time": "10:00~11:00",
        "title": "Team meeting",
        "description": "Discuss project updates and..."
      },
      {
        "time": "13:00~14:00",
        "title": "Client call",
        "description": "Call with the client regarding..."
      }
    ],
    // Add more events here
  };

  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<double>(begin: 300, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    // Trigger the animation for the initial selected day
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Calendar",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CalendarHeader(),
              const SizedBox(height: 16),
              _buildCalendar(context),
              const SizedBox(height: 16),
              GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    GoRouter.of(context).push(AppRouter.kscheduleView, extra: _selectedDay);
                  }
                },
                child: EventList(
                  events: _events[DateTime(
                    _selectedDay.year, _selectedDay.month, _selectedDay.day
                  )] ?? [],
                  slideAnimation: _slideAnimation,
                  fadeAnimation: _fadeAnimation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    return BlocBuilder<YearMonthPickerCubit, YearMonthPickerState>(
      builder: (context, state) {
        return TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime(state.displayedYear, state.selectedMonth),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = DateTime(
                  selectedDay.year, selectedDay.month, selectedDay.day);
              _animationController.reset();
              _animationController.forward();
            });
          },
          onPageChanged: (focusedDay) {
            context
                .read<YearMonthPickerCubit>()
                .changeYearAndMonth(focusedDay.year, focusedDay.month);
          },
          calendarStyle: CalendarStyle(
            defaultTextStyle: Theme.of(context).textTheme.bodyLarge!,
            weekendTextStyle: Theme.of(context).textTheme.bodyLarge!,
            selectedDecoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            todayDecoration: const BoxDecoration(
              color: Colors.pink,
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: false,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: Theme.of(context).textTheme.bodyLarge!,
            weekendStyle: Theme.of(context).textTheme.bodyLarge!,
            dowTextFormatter: (date, locale) {
              return DateFormat.E(locale)
                  .format(date)
                  .substring(0, 2)
                  .toUpperCase();
            },
          ),
          headerVisible: false,
        );
      },
    );
  }
}
