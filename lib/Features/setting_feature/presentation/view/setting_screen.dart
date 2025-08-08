import 'package:flutter/material.dart';
import 'package:wahaj_app/Features/setting_feature/presentation/view/widgets/setting_app_bar.dart';
import 'package:wahaj_app/Features/setting_feature/presentation/view/widgets/setting_body.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingAppBar(),
      body: SettingBody(),
    );
  }
}
