import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wahaj_app/Features/home_feature/data/models/task_model.dart';

part 'delete_all_tasks_state.dart';

class DeleteAllTasksCubit extends Cubit<DeleteAllTasksState> {
  DeleteAllTasksCubit() : super(DeleteAllTasksInitial());

  void deleteAllTasks(List<TaskModel> tasks) {
    for (var task in tasks) {
      task.delete();
    }
    emit(DeleteAllTasksSuccess());
  }
}
