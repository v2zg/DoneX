import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wahaj_app/Features/home_feature/data/models/task_model.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit() : super(DeleteTaskCubitInitial());

  void deleteTask(TaskModel task) {
    task.delete();
    emit(DeleteTaskCubitSuccess());
  }
}
