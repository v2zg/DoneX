import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/delete_task_cubit/delete_task_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:wahaj_app/Features/home_feature/data/models/task_model.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/checkbox_task.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/primary_button.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/task_app_bar.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is TasksLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TasksError) {
          return Center(child: Text(state.message));
        }
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: TaskAppBar(
            taskTime: taskModel.time,
          ),
          body: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 12.h,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // the main task
                      CheckboxTask(
                        title: taskModel.title,
                        value: taskModel.isCompleted,
                        onChanged: (value) {
                          context
                              .read<TasksCubit>()
                              .toggleTaskCompleted(taskModel, value!);
                        },
                      ),
                      SizedBox(height: 12.h),

                      // the subtasks section
                      // title of section
                      Text(
                        'المهام الفرعية',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // list of subtasks checkbox
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: taskModel.subTasks.length,
                          itemBuilder: (context, index) {
                            return CheckboxTask(
                              title: taskModel.subTasks[index],
                              value: taskModel.subTasksCompleted![index],
                              onChanged: (value) {
                                taskModel.subTasksCompleted![index] = value!;
                                context
                                    .read<TasksCubit>()
                                    .updateTask(taskModel);
                              },
                            );
                          }),

                      // مساحة وهمية لضمان عدم تغطية المحتوى
                      SizedBox(height: 200.h)
                    ],
                  ),
                ),
              ),

              // تثبيت الأزرار في الأسفل
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.only(
                      right: 20.w, left: 20.w, top: 12.h, bottom: 34.h),
                  child: Column(
                    spacing: 16.h,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryButton(
                        text: 'تعديل المهمة',
                        color: Theme.of(context).primaryColor,
                        onPressed: () {},
                      ),
                      PrimaryButton(
                        text: 'حذف المهمة',
                        color: Theme.of(context).cardColor,
                        onPressed: () {
                          BlocProvider.of<DeleteTaskCubit>(context)
                              .deleteTask(taskModel);
                          BlocProvider.of<TasksCubit>(context).fetchAllTasks();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
