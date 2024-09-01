import 'package:educational_institute/features/home/presentation/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  final screens = [
    const HomeView(),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.yellow,
    ),
  ];

  void updateIndex(int newIndex) {
    emit(newIndex);
  }
}
