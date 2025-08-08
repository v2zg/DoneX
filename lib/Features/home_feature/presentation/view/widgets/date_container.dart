import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/day_box.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/calendar_cubit/calendar_cubit.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final weekday = state.baseWeekDate.weekday;
        final daysToSubtract = weekday == 7 ? 0 : weekday;
        final weekStart =
            state.baseWeekDate.subtract(Duration(days: daysToSubtract));
        final selectedDate = state.selectedDate;

        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 16.h),

              // ✅ اليوم الحالي (بتنسيق عربي)
              Text(
                DateFormat('EEEE، d MMMM yyyy', 'ar').format(selectedDate),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontFamily: 'Alexandria',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 16.h),

              // ✅ أيام الأسبوع
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4.w,
                children: List.generate(7, (index) {
                  final date = weekStart.add(Duration(days: index));
                  final isSelected = DateUtils.isSameDay(date, selectedDate);

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<CalendarCubit>().selectDate(date);
                      },
                      child: DayBox(
                        date: date,
                        isSelected: isSelected,
                        isToday: DateUtils.isSameDay(date, DateTime.now()),
                      ),
                    ),
                  );
                }).reversed.toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
