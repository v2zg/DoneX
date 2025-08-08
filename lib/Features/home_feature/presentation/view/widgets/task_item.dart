import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wahaj_app/Features/home_feature/data/models/task_model.dart';
import 'package:wahaj_app/core/constants.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/task_screen.dart';

class TaskItem extends StatelessWidget {
  final VoidCallback? onTap;
  final TaskModel task;

  const TaskItem({super.key, this.onTap, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 400),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  TaskScreen(
                taskModel: task,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final tween =
                    Tween(begin: const Offset(0, 1), end: Offset.zero);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                );
                return SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: child,
                );
              },
            ),
          );
        },
        contentPadding: EdgeInsets.all(0),
        title: Column(
          spacing: 8.h,
          children: [
            // head of task
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Task completion time ✅ تعديل الوقت هنا
                Text(
                  convertToArabicTime(task.time),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                // Title of task
                Text(
                  task.title,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            // footer of task
            Text(
              "عرض المهام الفرعية",
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withAlpha(120),
                fontSize: 10.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
