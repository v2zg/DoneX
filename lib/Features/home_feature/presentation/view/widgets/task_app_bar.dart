// 📁 lib/Features/home_feature/presentation/view/widget/task_app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wahaj_app/core/widgets/return_button.dart';

class TaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String taskTime;

  const TaskAppBar({
    Key? key,
    required this.taskTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // return button
            ReturnButton(),
            Expanded(
              child: Column(
                spacing: 8.h,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'استعراض المهمة',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  taskTime.isEmpty
                      ? Text(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          'لم يتم تسجيل وقت',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                              fontSize: 12.sp),
                        )
                      : Text(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          'وقت بدء المهمة  $taskTime',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                              fontSize: 12.sp),
                        )
                ],
              ),
            ),
            Opacity(
              opacity: 0,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/returnIcon.svg',
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
