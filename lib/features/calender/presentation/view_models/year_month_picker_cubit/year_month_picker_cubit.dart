import 'package:flutter_bloc/flutter_bloc.dart';

class YearMonthPickerState {
  final int displayedYear;
  final int selectedMonth;

  YearMonthPickerState({
    required this.displayedYear,
    required this.selectedMonth,
  });

  YearMonthPickerState copyWith({
    int? displayedYear,
    int? selectedMonth,
  }) {
    return YearMonthPickerState(
      displayedYear: displayedYear ?? this.displayedYear,
      selectedMonth: selectedMonth ?? this.selectedMonth,
    );
  }
}

class YearMonthPickerCubit extends Cubit<YearMonthPickerState> {
  YearMonthPickerCubit(int initialYear, int initialMonth)
      : super(YearMonthPickerState(
          displayedYear: initialYear,
          selectedMonth: initialMonth,
        ));

  void changeYear(int year) {
    emit(state.copyWith(displayedYear: year));
  }

  void selectMonth(int month) {
    emit(state.copyWith(selectedMonth: month));
  }

  void changeYearAndMonth(int year, int month) {
    emit(state.copyWith(displayedYear: year, selectedMonth: month));
  }
}
