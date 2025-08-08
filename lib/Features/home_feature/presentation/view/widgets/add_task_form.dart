import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/add_task_cubit/add_task_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view_model/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:wahaj_app/Features/home_feature/data/models/task_model.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/custom_text_field.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/custom_time_picker.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/primary_button.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/small_custom_button.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final List<TextEditingController> subtaskControllers = [
    TextEditingController()
  ];

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? title;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 24.h,
              children: [
                // title of sheet
                Text(
                  "اضافة مهمة جديدة",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // inputs section
                Column(
                  spacing: 24.h,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // title of task
                    Text(
                      "عنوان المهمة",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    // input field
                    CustomTextField(
                      hint: 'ادخل عنوان المهمة',
                      onSaved: (value) {
                        title = value;
                      },
                      controller: null,
                    ),

                    // subtask section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Add subtask button
                        SmallCustomButton(
                          text: 'اضافة مهمة فرعية',
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              subtaskControllers.add(TextEditingController());
                            });
                          },
                        ),

                        // title of subtask section
                        Text(
                          "المهام الفرعية",
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),

                    // قائمة المهام الفرعية
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: subtaskControllers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  subtaskControllers.removeAt(index);
                                });
                              },
                              icon: SvgPicture.asset(
                                "assets/icons/deleteIcon.svg",
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  CustomTextField(
                                    hint: 'المهمة الفرعية ${index + 1}',
                                    controller: subtaskControllers[index],
                                  ),
                                  SizedBox(height: 8.h),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    // time of task
                    CustomTimePicker(
                      selectedTime: selectedTime,
                      onTimeSelected: (time) {
                        setState(() {
                          selectedTime = time;
                        });
                      },
                    ),

                    // add task button
                    BlocBuilder<AddTaskCubit, AddTaskState>(
                      builder: (context, state) {
                        return PrimaryButton(
                          isLoading: state is AddTaskLoading ? true : false,
                          text: 'اضافة',
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              final subTasks = subtaskControllers
                                  .map((controller) => controller.text)
                                  .where((text) => text.trim().isNotEmpty)
                                  .toList();

                              final subTasksCompleted =
                                  List<bool>.filled(subTasks.length, false);

                              var taskModel = TaskModel(
                                title: title!,
                                subTasks: subTasks,
                                subTasksCompleted: subTasksCompleted,
                                time: selectedTime?.format(context) ?? '',
                                date: context
                                    .read<CalendarCubit>()
                                    .state
                                    .selectedDate, // ✅ هنا
                              );

                              BlocProvider.of<AddTaskCubit>(context)
                                  .addTask(taskModel);
                              BlocProvider.of<TasksCubit>(context)
                                  .fetchAllTasks();
                            } else {
                              autovalidateMode = AutovalidateMode.always;
                              setState(() {});
                            }
                          },
                        );
                      },
                    ),

                    // safe area
                    SizedBox(height: 20.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
