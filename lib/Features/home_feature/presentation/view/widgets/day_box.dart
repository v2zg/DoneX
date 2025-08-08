import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayBox extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  const DayBox({
    super.key,
    required this.date,
    required this.isSelected,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).primaryColor
            : isToday
                ? Theme.of(context).primaryColor.withOpacity(0.5)
                : Theme.of(context).cardColor,
        border: isToday
            ? Border.all(color: Theme.of(context).primaryColor, width: 2)
            : null,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            '${date.day}',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          Text(
            getShortArabicDayName(date),
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

String getShortArabicDayName(DateTime date) {
  switch (date.weekday) {
    case DateTime.sunday:
      return 'ح';
    case DateTime.monday:
      return 'ثن';
    case DateTime.tuesday:
      return 'ثل';
    case DateTime.wednesday:
      return 'ر';
    case DateTime.thursday:
      return 'خ';
    case DateTime.friday:
      return 'جم';
    case DateTime.saturday:
      return 'س';
    default:
      return '';
  }
}
