import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/delete_all_task_alert.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/task_item.dart';

class CompletedTasksList extends StatefulWidget {
  final String? titleOfSection;
  const CompletedTasksList({super.key, required this.titleOfSection});

  @override
  State<CompletedTasksList> createState() => _CompletedTasksListState();
}

class _CompletedTasksListState extends State<CompletedTasksList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is! TasksSuccess) {
          return SizedBox.shrink(); // أو Spinner لو تبي
        }

        final selectedDate = context.watch<CalendarCubit>().state.selectedDate;

        final completedTasks = state.tasks
            .where((task) =>
                task.isCompleted &&
                DateUtils.isSameDay(task.date, selectedDate))
            .toList();

        return Column(
          children: [
            // عنوان القسم
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            DeleteAllTaskAlert(tasks: completedTasks));
                  },
                  // _deleteAllCompletedTasks(context), // ✅ زر الحذف
                  icon: SvgPicture.asset(
                    "assets/icons/deleteIcon.svg",
                    width: 24.w,
                    height: 24.h,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyMedium!.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                ),

                // title o section
                Text(
                  completedTasks.length > 10
                      ? '🔥${completedTasks.length} المهام المكتملة'
                      : completedTasks.length == 2
                          ? '🔥مهمتين مكتملة'
                          : completedTasks.length == 1
                              ? '🔥مهمة واحدة مكتملة'
                              : '🔥${completedTasks.length} المهام المكتملة',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            completedTasks.isEmpty
                ? Center(
                    child: Text(
                      'لا يوجد مهام مكتملة',
                      style: TextStyle(color: Theme.of(context).cardColor),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: completedTasks.length,
                    itemBuilder: (context, index) {
                      final currentTask = completedTasks[index];

                      return Dismissible(
                        key: ValueKey(currentTask),
                        background: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Icon(Icons.undo, color: Colors.white),
                          ),
                        ),
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            currentTask.isCompleted = false;
                            await currentTask.save();
                          } else if (direction == DismissDirection.startToEnd) {
                            await currentTask.delete();
                          }

                          BlocProvider.of<TasksCubit>(context).fetchAllTasks();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Opacity(
                            opacity: 0.5,
                            child: TaskItem(task: currentTask),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        );
      },
    );
  }
}
