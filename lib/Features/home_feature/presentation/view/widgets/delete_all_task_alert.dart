import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wahaj_app/Features/home_feature/data/models/task_model.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/primary_button.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/delete_all_tasks_cubit/delete_all_tasks_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/tasks_cubit/tasks_cubit.dart';

class DeleteAllTaskAlert extends StatelessWidget {
  const DeleteAllTaskAlert({
    super.key,
    required this.tasks,
  });

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsOverflowDirection: VerticalDirection.up,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 0, color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(24.r)),
      title: Text(
        'تنبيه !',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      ),
      content: Text(
        textAlign: TextAlign.center,
        'هل أنت متأكد من حذف جميع المهام ؟',
      ),
      actions: [
        PrimaryButton(
            text: 'الغاء',
            color: Theme.of(context).cardColor,
            onPressed: () => Navigator.of(context).pop()),
        SizedBox(
          height: 8.h,
        ),
        PrimaryButton(
            text: 'تأكيد الحذف',
            color: Theme.of(context).primaryColor,
            onPressed: () {
              BlocProvider.of<DeleteAllTasksCubit>(context)
                  .deleteAllTasks(tasks);
              BlocProvider.of<TasksCubit>(context).fetchAllTasks();
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
