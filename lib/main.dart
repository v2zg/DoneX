import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/delete_all_tasks_cubit/delete_all_tasks_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/delete_task_cubit/delete_task_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:wahaj_app/Features/home_feature/data/models/task_model.dart';
import 'package:wahaj_app/Features/setting_feature/presentation/view_model/cubits/theme_cubit/theme_cubit.dart';
import 'package:wahaj_app/core/utils/app_router.dart';
import 'package:wahaj_app/simple_bloc_observer.dart';
import 'package:wahaj_app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ar');
  await Hive.initFlutter();
  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('kTasksBox');
  await Hive.openBox('themeBox');

  runApp(
    BlocProvider<ThemeCubit>(
      create: (_) => ThemeCubit(),
      child: const MyApp(),
    ),
  );

  // ✅ Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // المقاسات الأساسية (مثلاً: iPhone X)
      minTextAdapt: true, // تكيف النصوص
      splitScreenMode: true, // دعم تقسيم الشاشة
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<TasksCubit>(
              create: (context) => TasksCubit()..fetchAllTasks(),
            ),
            BlocProvider<DeleteTaskCubit>(
              create: (context) => DeleteTaskCubit(),
            ),
            BlocProvider<DeleteAllTasksCubit>(
              create: (context) => DeleteAllTasksCubit(),
            ),
            BlocProvider<CalendarCubit>(
              create: (context) => CalendarCubit(),
            ),
          ],
          child: MaterialApp.router(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: context.watch<ThemeCubit>().state,
            debugShowCheckedModeBanner: false,
            title: 'DoneX',
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
