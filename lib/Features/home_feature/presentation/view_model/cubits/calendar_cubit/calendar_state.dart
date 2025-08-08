part of 'calendar_cubit.dart';

@immutable
sealed class CalendarState {
  final DateTime baseWeekDate;
  final DateTime selectedDate;

  const CalendarState({required this.selectedDate, required this.baseWeekDate});
}

final class CalendarInitial extends CalendarState {
  CalendarInitial()
      : super(baseWeekDate: DateTime.now(), selectedDate: DateTime.now());
}

final class CalendarDaySelected extends CalendarState {
  const CalendarDaySelected({
    required super.baseWeekDate,
    required super.selectedDate,
  });
}
