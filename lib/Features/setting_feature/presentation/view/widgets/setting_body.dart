import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wahaj_app/Features/setting_feature/presentation/view/widgets/setting_tile.dart';
import 'package:wahaj_app/Features/setting_feature/presentation/view_model/cubits/theme_cubit/theme_cubit.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16.h,
        children: [
          SettingTile(
            title: 'تفعيل الوضع الليلي',
            trailing: CupertinoSwitch(
              activeTrackColor: Theme.of(context).primaryColor,
              value: context.watch<ThemeCubit>().state == ThemeMode.dark,
              onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
            ),
          ),
          SettingTile(
            title: 'تفعيل التاريخ الهجري',
            trailing: CupertinoSwitch(
              activeTrackColor: Theme.of(context).primaryColor,
              value: false,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
