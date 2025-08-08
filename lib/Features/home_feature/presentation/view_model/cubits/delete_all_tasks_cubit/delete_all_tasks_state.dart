part of 'delete_all_tasks_cubit.dart';

@immutable
sealed class DeleteAllTasksState {}

final class DeleteAllTasksInitial extends DeleteAllTasksState {}

final class DeleteAllTasksSuccess extends DeleteAllTasksState {}
