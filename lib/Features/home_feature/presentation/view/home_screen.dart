import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/completed_tasks_list.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/date_container.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/filter_button.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/my_appbar.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/uncompleted_task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool reverseSections = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 24, left: 24),
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              Column(
                children: [
                  // Date section
                  DateContainer(),
                  SizedBox(height: 24.h),

                  // Task section
                  Column(
                    spacing: 16.h,
                    children: [
                      // section buttons
                      Row(
                        children: [
                          // filter button
                          FilterButton(
                            reverseSections: reverseSections,
                            onPressed: () {
                              setState(() {
                                reverseSections = !reverseSections;
                              });
                            },
                          ),
                        ],
                      ),

                      // All tasks
                      ListView(
                        reverse: reverseSections,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          // Uncompleted tasks section
                          UncompletedTaskList(),

                          SizedBox(height: 16.h),

                          // Completed tasks section
                          CompletedTasksList(
                            titleOfSection: '🔥المهام المنجزة 50 مهمة',
                          ),
                        ],
                      ),

                      // Footer
                      Text(
                        "صنع بـ 🧡 بواسطة muathCS@",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
