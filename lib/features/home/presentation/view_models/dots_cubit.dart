import 'package:bloc/bloc.dart';

class DotsCubit extends Cubit<int> {
  DotsCubit() : super(0);

  void changePage(int index) => emit(index);
}
