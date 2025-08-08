import 'package:hive_flutter/hive_flutter.dart';
import 'package:wahaj_app/Features/home_feature/data/models/task_model.dart';

// اسم البوكس كـ String
const String kTasksBox = 'kTasksBox';

// بوكس المهام
final Box<TaskModel> taskBox = Hive.box<TaskModel>(kTasksBox);

// ✅ دالة تحويل الوقت إلى م/ص
String convertToArabicTime(String time) {
  if (time.toLowerCase().contains('am')) {
    return time.replaceAll('AM', 'ص').replaceAll('am', 'ص');
  } else if (time.toLowerCase().contains('pm')) {
    return time.replaceAll('PM', 'م').replaceAll('pm', 'م');
  }
  return time;
}
