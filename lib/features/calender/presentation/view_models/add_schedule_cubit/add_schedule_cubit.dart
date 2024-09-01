import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Event state class
class EventState extends Equatable {
  final String title;
  final String description;
  final String alertOption;

  const EventState({
    this.title = '',
    this.description = '',
    this.alertOption = 'Alert me before a day',
  });

  EventState copyWith({
    String? title,
    String? description,
    String? alertOption,
  }) {
    return EventState(
      title: title ?? this.title,
      description: description ?? this.description,
      alertOption: alertOption ?? this.alertOption,
    );
  }

  @override
  List<Object> get props => [title, description, alertOption];
}

// Event cubit class
class EventCubit extends Cubit<EventState> {
  EventCubit() : super(const EventState());

  void setTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void setAlertOption(String alertOption) {
    emit(state.copyWith(alertOption: alertOption));
  }
}
