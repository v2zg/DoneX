import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wahaj_app/core/constants.dart';
import 'package:wahaj_app/Features/home_feature/data/models/task_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  List<TaskModel>? tasks;

  void fetchAllTasks() async {
    emit(TasksLoading());
    try {
      final allTasks = taskBox.values.toList();

      // ✅ نزامن المهام الفرعية
      for (var task in allTasks) {
        task.syncSubTasks();
      }

      allTasks.sort((a, b) => a.position.compareTo(b.position));
      emit(TasksSuccess(allTasks));
    } catch (e) {
      emit(TasksError('فشل تحميل المهام'));
    }
  }

  void updateTask(TaskModel task) async {
    await task.save(); // نحفظ التغييرات في Hive
    fetchAllTasks(); // نعيد تحميل المهام
  }

  List<TaskModel> getTasksForDate(DateTime date) {
    if (tasks == null) return [];
    return tasks!
        .where((task) => DateUtils.isSameDay(task.date, date))
        .toList();
  }

  void completeTask(TaskModel task) async {
    task.isCompleted = true;
    await task.save();
    fetchAllTasks();
  }

  void toggleTaskCompleted(TaskModel task, bool isCompleted) async {
    task.isCompleted = isCompleted;
    await task.save();
    fetchAllTasks();
  }
}
