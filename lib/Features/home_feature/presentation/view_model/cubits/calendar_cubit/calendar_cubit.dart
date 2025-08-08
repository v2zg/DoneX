import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());

  void selectDate(DateTime date) {
    emit(CalendarDaySelected(
        baseWeekDate: state.baseWeekDate, selectedDate: date));
  }
}
