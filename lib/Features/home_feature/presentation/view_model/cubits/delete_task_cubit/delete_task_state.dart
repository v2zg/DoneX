part of 'delete_task_cubit.dart';

@immutable
sealed class DeleteTaskState {}

final class DeleteTaskCubitInitial extends DeleteTaskState {}

final class DeleteTaskCubitSuccess extends DeleteTaskState {}

final class DeleteTaskCubitFailure extends DeleteTaskState {
  final String? errMessage;

  DeleteTaskCubitFailure({this.errMessage});
}
