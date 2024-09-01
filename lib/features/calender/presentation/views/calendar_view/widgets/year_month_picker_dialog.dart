import 'package:educational_institute/features/calender/presentation/view_models/year_month_picker_cubit/year_month_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educational_institute/core/utils/constants/app_colors.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';

class YearMonthPickerDialog extends StatelessWidget {
  final int selectedYear;
  final int selectedMonth;
  final Function(int, int) onYearMonthSelected;

  const YearMonthPickerDialog({
    super.key,
    required this.selectedYear,
    required this.selectedMonth,
    required this.onYearMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => YearMonthPickerCubit(selectedYear, selectedMonth),
      child: BlocBuilder<YearMonthPickerCubit, YearMonthPickerState>(
        builder: (context, state) {
          double containerWidth =
              HelperFunctions.screenWidth(context) * 0.35; // Adjusted width

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left),
                    onPressed: () {
                      context
                          .read<YearMonthPickerCubit>()
                          .changeYear(state.displayedYear - 1);
                      onYearMonthSelected(
                          state.displayedYear - 1, state.selectedMonth);
                    },
                  ),
                  Text('${state.displayedYear}',
                      style: Theme.of(context).textTheme.headlineSmall!),
                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: () {
                      context
                          .read<YearMonthPickerCubit>()
                          .changeYear(state.displayedYear + 1);
                      onYearMonthSelected(
                          state.displayedYear + 1, state.selectedMonth);
                    },
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3, // Adjusted aspect ratio
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<YearMonthPickerCubit>()
                          .selectMonth(index + 1);
                      onYearMonthSelected(state.displayedYear, index + 1);
                    },
                    child: Container(
                      width: containerWidth, // Adjust the width as needed
                      height: HelperFunctions.screenHeight(context) *
                          0.1, // Adjusted height
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: state.selectedMonth == index + 1
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          _monthName(index + 1),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: state.selectedMonth == index + 1
                                ? Colors.white
                                : Colors.black,
                            fontWeight: state.selectedMonth == index + 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
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
