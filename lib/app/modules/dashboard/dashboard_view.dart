import 'package:andin_project/app/modules/home/home_view.dart';
import 'package:andin_project/app/modules/profile/profile_view.dart';
import 'package:andin_project/app/modules/question/question_management/question_management_view.dart';
import 'package:andin_project/app/modules/student/student_management/student_management_view.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: controller.tabController,
      tabs: [
        PersistentTabConfig(
          screen: HomeView(),
          item: ItemConfig(
            icon: Icon(Icons.home),
            title: 'button_home'.tr,
          ),
        ),
        PersistentTabConfig(
          screen: QuestionManagementView(),
          item: ItemConfig(
            icon: Icon(Icons.question_answer),
            title: 'button_question'.tr,
          ),
        ),
        PersistentTabConfig(
          screen: StudentManagementView(),
          item: ItemConfig(
            icon: Icon(Icons.people),
            title: 'button_student'.tr,
          ),
        ),
        PersistentTabConfig(
          screen: ProfileView(),
          item: ItemConfig(
            icon: Icon(Icons.person),
            title: 'button_profile'.tr,
          ),
        ),
      ],
      screenTransitionAnimation: ScreenTransitionAnimation(
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceIn,
      ),
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}
