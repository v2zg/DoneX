import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CheckboxTask extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CheckboxTask({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
          height: 1,
        ),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: value
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: value
                      ? SvgPicture.asset(
                          'assets/icons/checkmarkIcon.svg',
                          width: 16.w,
                          height: 16.w,
                        )
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: value
                          ? Theme.of(context).dividerColor
                          : Theme.of(context).textTheme.bodyMedium!.color,
                      decoration: value
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontWeight: FontWeight.w400,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
          height: 1,
        ),
      ],
    );
  }
}
