import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/add_task_cubit/add_task_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/add_new_task_sheet.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/primary_button.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 24.h,
            children: [
              // add new task button
              PrimaryButton(
                text: 'انشئ مهمة جديدة',
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return BlocProvider(
                          create: (context) => AddTaskCubit(),
                          child: AddNewTaskSheet());
                    },
                  );
                },
              ),

              // add new workspace button
              PrimaryButton(
                text: 'انشئ مساحة عمل جديدة',
                color: Theme.of(context).cardColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
