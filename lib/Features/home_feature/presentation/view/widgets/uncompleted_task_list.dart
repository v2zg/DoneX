import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/delete_all_task_alert.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/delete_task_cubit/delete_task_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/task_item.dart';

class UncompletedTaskList extends StatefulWidget {
  const UncompletedTaskList({super.key});

  @override
  State<UncompletedTaskList> createState() => _UncompletedTaskListState();
}

class _UncompletedTaskListState extends State<UncompletedTaskList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is! TasksSuccess) {
          return SizedBox.shrink(); // أو Spinner إذا تحب
        }

        final selectedDate = context.watch<CalendarCubit>().state.selectedDate;

        final tasks = state.tasks
            .where((task) =>
                !task.isCompleted &&
                DateUtils.isSameDay(task.date, selectedDate))
            .toList();

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteAllTaskAlert(tasks: tasks),
                    );
                  },
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
                Text(
                  tasks.length > 10
                      ? '⏳لديك ${tasks.length} مهمة تنتظرك'
                      : tasks.length == 2
                          ? '⏳لديك مهمتين تنتظرك'
                          : tasks.length == 1
                              ? '⏳لديك مهمة واحدة تنتظرك'
                              : '⏳لديك ${tasks.length} مهام تنتظرك',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            tasks.isEmpty
                ? Center(
                    child: Text(
                      'لا يوجد لديك مهام',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  )
                : ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    onReorder: (oldIndex, newIndex) async {
                      setState(() {
                        if (newIndex > oldIndex) newIndex -= 1;
                        final item = tasks.removeAt(oldIndex);
                        tasks.insert(newIndex, item);
                      });

                      for (int i = 0; i < tasks.length; i++) {
                        tasks[i].position = i;
                        await tasks[i].save();
                      }

                      context.read<TasksCubit>().fetchAllTasks();
                    },
                    itemBuilder: (context, index) {
                      final currentTask = tasks[index];
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
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                        ),
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction) {
                          final removedTask = currentTask;

                          setState(() {
                            tasks.removeAt(index);
                          });

                          if (direction == DismissDirection.endToStart) {
                            context
                                .read<TasksCubit>()
                                .completeTask(removedTask);
                          } else if (direction == DismissDirection.startToEnd) {
                            context
                                .read<DeleteTaskCubit>()
                                .deleteTask(removedTask);
                            context.read<TasksCubit>().fetchAllTasks();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: TaskItem(task: currentTask),
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
