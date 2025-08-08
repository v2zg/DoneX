// 📁 lib/Features/home_feature/presentation/view/widget/filter_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wahaj_app/theme/app_colors.dart';

class FilterButton extends StatelessWidget {
  final bool reverseSections;
  final VoidCallback onPressed;

  const FilterButton({
    Key? key,
    required this.reverseSections,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reverseSections
        ? ElevatedButton.icon(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.grey,
              backgroundColor: Theme.of(context).primaryColor,
              side: BorderSide(
                  style: BorderStyle.solid,
                  width: 2,
                  color: Theme.of(context).primaryColor),
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
            label: Text(
              'اخفاء المهام المكتملة',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 12.sp),
            ),
          )
        : OutlinedButton.icon(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              overlayColor: Colors.grey,
              side: BorderSide(
                  style: BorderStyle.solid,
                  width: 2,
                  color: AppColors.darkPrimary),
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
            label: Text(
              'عرض المهام المكتملة',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 12.sp),
            ));
  }
}
