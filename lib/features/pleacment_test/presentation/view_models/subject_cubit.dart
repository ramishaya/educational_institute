import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectCubit extends Cubit<SubjectState> {
  SubjectCubit() : super(SubjectInitial());

  static SubjectCubit get(context) => BlocProvider.of(context);

  final List<String> subjects = [
    'إنكليزي',
    'عربي',
    'فرنسي',
    'ألماني',
    'إسباني'
  ];

  String? selectedSubject;
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  void updateSubject(String subject) {
    selectedSubject = subject;
    emit(SubjectUpdated(subject));
  }
}

abstract class SubjectState {}

class SubjectInitial extends SubjectState {}

class SubjectUpdated extends SubjectState {
  final String subject;

  SubjectUpdated(this.subject);
}
