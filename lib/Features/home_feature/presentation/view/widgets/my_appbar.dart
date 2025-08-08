import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wahaj_app/Features/home_feature/presentation/view/widgets/add_bottom_sheet.dart';
import 'package:wahaj_app/core/utils/app_router.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(160.h);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // المربع الثالث في الاستاك
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: Color.fromARGB(100, 217, 65, 45),
            ),
          ),
        ),

        // المربع الثاني في الاستاك
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 150.h,
            decoration: BoxDecoration(
              color: Color.fromARGB(133, 217, 65, 45),
            ),
          ),
        ),

        // مربع البيانات
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          child: Container(
            height: 140.h,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 217, 65, 45),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 45, right: 24, left: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // setting button
                  CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: FittedBox(
                      fit: BoxFit.none,
                      child: IconButton(
                        onPressed: () {
                          GoRouter.of(context).push(AppRouter.settingScreen);
                        },
                        icon: SvgPicture.asset(
                          "assets/icons/settingIcon.svg",
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).textTheme.bodyMedium!.color!,
                              BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  //
                  //---- name of the work space
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16.h,
                    children: [
                      Text(
                        "مساحة عمل الدراسة",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Alexandria',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 8, // حجم الدائرة
                            height: 8, // حجم الدائرة
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 2
                                  ? Color(
                                      0xFF131313) // اللون الأسود للنقطة المختارة
                                  : Colors.white, // اللون الأبيض للبقية
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  //
                  // ----- button to add new workspace
                  CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: FittedBox(
                      fit: BoxFit.none,
                      child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.white.withAlpha(0),
                                context: context,
                                builder: (context) {
                                  return AddBottomSheet();
                                });
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/plusIcon.svg",
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).textTheme.bodyMedium!.color!,
                                BlendMode.srcIn),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
