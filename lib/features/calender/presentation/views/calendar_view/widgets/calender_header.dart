import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/constants/sizes.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:educational_institute/features/calender/presentation/view_models/add_schedule_cubit/add_schedule_cubit.dart';
import 'package:educational_institute/features/calender/presentation/view_models/year_month_picker_cubit/year_month_picker_cubit.dart';
import 'package:educational_institute/features/calender/presentation/views/calendar_view/widgets/year_month_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    return BlocBuilder<YearMonthPickerCubit, YearMonthPickerState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogBackgroundColor:
                      isDarkMode ? AppColors.dark : AppColors.light,
                  headerAnimationLoop: false,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  width: MediaQuery.of(context).size.width,
                  dialogType: DialogType.noHeader,
                  animType: AnimType.rightSlide,
                  body: YearMonthPickerDialog(
                    selectedYear: state.displayedYear,
                    selectedMonth: state.selectedMonth,
                    onYearMonthSelected: (year, month) {
                      context
                          .read<YearMonthPickerCubit>()
                          .changeYearAndMonth(year, month);
                    },
                  ),
                ).show();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _monthName(state.selectedMonth),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, size: 24),
                    ],
                  ),
                  Text(
                    '${state.displayedYear}',
                    style:Theme.of(context).textTheme.bodyLarge
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _showAddEventDialog(context, isDarkMode);
              },
              child: Container(
                padding:
                    EdgeInsets.all(HelperFunctions.screenWidth(context) * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.primaryColor,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 20,
                    ),
                    SizedBox(
                        width: HelperFunctions.screenWidth(context) * 0.01),
                    Text('Add schedule',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.white)),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddEventDialog(BuildContext context, bool isDarkMode) {
    AwesomeDialog(
      width: HelperFunctions.screenWidth(context),
      context: context,
      dialogBackgroundColor: isDarkMode ? AppColors.dark : AppColors.light,
      dialogType: DialogType.noHeader,
      animType: AnimType.leftSlide,
      body: BlocProvider(
        create: (context) => EventCubit(),
        child: Builder(
          builder: (newContext) {
            final cubit = newContext.read<EventCubit>();

            return BlocBuilder<EventCubit, EventState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(HelperFunctions.screenWidth(context) *
                      AppSizes.horizintalMarginPercent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add New Schedule',
                          style: Theme.of(context).textTheme.headlineSmall),
                      SizedBox(
                          height: HelperFunctions.screenHeight(context) * 0.02),
                      TextField(
                        cursorColor: AppColors.primaryColor,
                        onChanged: (value) => cubit.setTitle(value),
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                          height: HelperFunctions.screenHeight(context) * 0.02),
                      TextField(
                        cursorColor: AppColors.primaryColor,
                        onChanged: (value) => cubit.setDescription(value),
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                          height: HelperFunctions.screenHeight(context) * 0.02),
                      Text('Alert Options',
                          style: Theme.of(context).textTheme.bodyLarge),
                      RadioListTile(
                        activeColor: AppColors.primaryColor,
                        title: const Text('Alert me before a day'),
                        value: 'Alert me before a day',
                        groupValue: state.alertOption,
                        onChanged: (value) {
                          cubit.setAlertOption(value.toString());
                        },
                      ),
                      RadioListTile(
                        activeColor: AppColors.primaryColor,
                        title: const Text('Alert me in the same day'),
                        value: 'Alert me in the same day',
                        groupValue: state.alertOption,
                        onChanged: (value) {
                          cubit.setAlertOption(value.toString());
                        },
                      ),
                      SizedBox(
                          height: HelperFunctions.screenHeight(context) * 0.02),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Add event to the calendar (you can extend this logic)
                              // For now, we'll just print the values
                              // ignore: avoid_print
                              print('Title: ${state.title}');
                              // ignore: avoid_print
                              print('Description: ${state.description}');
                              // ignore: avoid_print
                              print('Alert Option: ${state.alertOption}');

                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Add Schedule'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    ).show();
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
