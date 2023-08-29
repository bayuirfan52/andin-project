import 'package:andin_project/app/core/resources/app_color.dart';
import 'package:andin_project/app/modules/home/home_view.dart';
import 'package:andin_project/app/modules/profile/profile_view.dart';
import 'package:andin_project/app/modules/question/question_management/question_management_view.dart';
import 'package:andin_project/app/modules/student/student_management/student_management_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.tabController,
      resizeToAvoidBottomInset: true,
      screens: const [
        HomeView(),
        QuestionManagementView(),
        StudentManagementView(),
        ProfileView(),
      ],
      screenTransitionAnimation: ScreenTransitionAnimation(
        duration: Duration(milliseconds: 200),
        animateTabTransition: true,
        curve: Curves.bounceIn,
      ),
      items: _navBarItems(),
      navBarStyle: NavBarStyle.style6,
    );
  }

  List<PersistentBottomNavBarItem> _navBarItems() => [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: 'button_home'.tr,
          activeColorPrimary: colorPrimary,
          inactiveColorPrimary: colorGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.question_answer),
          title: 'button_question'.tr,
          activeColorPrimary: colorPrimary,
          inactiveColorPrimary: colorGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.people),
          title: 'button_student'.tr,
          activeColorPrimary: colorPrimary,
          inactiveColorPrimary: colorGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: 'button_profile'.tr,
          activeColorPrimary: colorPrimary,
          inactiveColorPrimary: colorGrey,
        ),
      ];
}
