import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/add_task_cubit/add_task_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/add_task_form.dart';

class AddNewTaskSheet extends StatelessWidget {
  const AddNewTaskSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        child: BlocConsumer<AddTaskCubit, AddTaskState>(
          listener: (context, state) {
            if (state is AddTaskFailure) {
              print('failired ${state.errorMessage}');
            }
            if (state is AddTaskSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is AddTaskLoading ? true : false,
              child: AddTaskForm(),
            );
          },
        ),
      ),
    );
  }
}
