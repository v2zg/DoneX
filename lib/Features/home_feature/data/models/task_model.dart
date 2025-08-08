import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final List<String> subTasks;

  @HiveField(2)
  final String time;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  int position;

  @HiveField(5)
  List<bool>? subTasksCompleted; // ✅ يخزن حالة كل subtask (صح/لا)

  @HiveField(6)
  final DateTime date; // 📅 يمثل يوم المهمة

  TaskModel({
    required this.title,
    required this.subTasks,
    required this.time,
    required this.date,
    this.isCompleted = false,
    this.position = 0,
    this.subTasksCompleted, // ممكن تكون null
  });

  /// ✅ دالة لتأكيد تزامن عدد الحالات مع عدد المهام
  void syncSubTasks() {
    final updated = List<bool>.filled(subTasks.length, false);
    for (int i = 0;
        i < (subTasksCompleted?.length ?? 0) && i < subTasks.length;
        i++) {
      updated[i] = subTasksCompleted![i];
    }
    subTasksCompleted = updated;
  }
}
