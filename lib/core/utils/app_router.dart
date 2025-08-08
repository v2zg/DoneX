import 'package:go_router/go_router.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/home_screen.dart';
import 'package:wahaj_app/Features/setting_feature/presentation/view/setting_screen.dart';

abstract class AppRouter {
  static const homeScreen = '/homeScreen';
  static const settingScreen = '/settingScreen';

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: settingScreen,
      builder: (context, state) => const SettingScreen(),
    ),
  ]);
}
