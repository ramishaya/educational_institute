import 'package:educational_institute/core/common/widgets/buttons/custom_back_button.dart';
import 'package:educational_institute/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleView extends StatelessWidget {
  final DateTime selectedMonth;
  
  const ScheduleView({super.key, required this.selectedMonth});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    final List<DateTime> daysInMonth = List.generate(
      DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day,
      (index) => DateTime(selectedMonth.year, selectedMonth.month, index + 1),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            CustomBackButton(isDarkMode: isDarkMode),
            Text(
              "Schedule",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daysInMonth.length,
              itemBuilder: (context, index) {
                final day = daysInMonth[index];
                return DayCard(day: day);
              },
            ),
          ),
          const Center(child: Text("hello every one ")),
        ],
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  final DateTime day;
  
  const DayCard({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String dayOfWeek = DateFormat.E().format(day).substring(0, 2).toUpperCase();
    final String dayOfMonth = day.day.toString();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Container(
        width: 60,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayOfWeek,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              dayOfMonth,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
