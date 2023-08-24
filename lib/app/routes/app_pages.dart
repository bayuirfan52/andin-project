import 'package:get/get.dart';

import '../extensions/string_extensions.dart';
import '../helper/preference_helper.dart';
import '../modules/dashboard/dashboard_binding.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/dev_tools/dev_tools_binding.dart';
import '../modules/dev_tools/dev_tools_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/media/audio_recorder/audio_recorder_binding.dart';
import '../modules/media/audio_recorder/audio_recorder_view.dart';
import '../modules/media/image_preview/image_preview_binding.dart';
import '../modules/media/image_preview/image_preview_view.dart';
import '../modules/profile/profile_binding.dart';
import '../modules/profile/profile_view.dart';
import '../modules/question/list_question/list_question_binding.dart';
import '../modules/question/list_question/list_question_view.dart';
import '../modules/question/question_detail/question_detail_binding.dart';
import '../modules/question/question_detail/question_detail_view.dart';
import '../modules/question/question_management/add_question/add_question_binding.dart';
import '../modules/question/question_management/add_question/add_question_view.dart';
import '../modules/question/question_management/edit_question/edit_question_binding.dart';
import '../modules/question/question_management/edit_question/edit_question_view.dart';
import '../modules/question/question_management/list_question_edit/list_question_edit_binding.dart';
import '../modules/question/question_management/list_question_edit/list_question_edit_view.dart';
import '../modules/question/question_management/question_management_binding.dart';
import '../modules/question/question_management/question_management_view.dart';
import '../modules/student/add_student/add_student_binding.dart';
import '../modules/student/add_student/add_student_view.dart';
import '../modules/student/edit_student/edit_student_binding.dart';
import '../modules/student/edit_student/edit_student_view.dart';
import '../modules/student/select_student/select_student_binding.dart';
import '../modules/student/select_student/select_student_view.dart';
import '../modules/student/student_detail/student_detail_binding.dart';
import '../modules/student/student_detail/student_detail_view.dart';
import '../modules/student/student_management/student_management_binding.dart';
import '../modules/student/student_management/student_management_view.dart';

// ignore_for_file: inference_failure_on_instance_creation

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String initial = PreferenceHelper.getTeacherName().isNullOrEmpty
      ? Routes.LOGIN
      : Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.IMAGE_PREVIEW,
      page: () => const ImagePreviewView(),
      binding: ImagePreviewBinding(),
    ),
    GetPage(
      name: Routes.AUDIO_RECORDER,
      page: () => const AudioRecorderView(),
      binding: AudioRecorderBinding(),
    ),
    GetPage(
      name: Routes.SELECT_STUDENT,
      page: () => const SelectStudentView(),
      binding: SelectStudentBinding(),
    ),
    GetPage(
      name: Routes.DEV_TOOLS,
      page: () => const DevToolsView(),
      binding: DevToolsBinding(),
    ),
    GetPage(
      name: Routes.ADD_STUDENT,
      page: () => const AddStudentView(),
      binding: AddStudentBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.STUDENT_MANAGEMENT,
      page: () => const StudentManagementView(),
      binding: StudentManagementBinding(),
    ),
    GetPage(
      name: Routes.EDIT_STUDENT,
      page: () => const EditStudentView(),
      binding: EditStudentBinding(),
    ),
    GetPage(
      name: Routes.QUESTION_MANAGEMENT,
      page: () => const QuestionManagementView(),
      binding: QuestionManagementBinding(),
    ),
    GetPage(
      name: Routes.ADD_QUESTION,
      page: () => const AddQuestionView(),
      binding: AddQuestionBinding(),
    ),
    GetPage(
      name: Routes.EDIT_QUESTION,
      page: () => const EditQuestionView(),
      binding: EditQuestionBinding(),
    ),
    GetPage(
      name: Routes.LIST_QUESTION,
      page: () => const ListQuestionView(),
      binding: ListQuestionBinding(),
    ),
    GetPage(
      name: Routes.LIST_QUESTION_EDIT,
      page: () => const ListQuestionEditView(),
      binding: ListQuestionEditBinding(),
    ),
    GetPage(
      name: Routes.STUDENT_DETAIL,
      page: () => const StudentDetailView(),
      binding: StudentDetailBinding(),
    ),
    GetPage(
      name: Routes.QUESTION_DETAIL,
      page: () => const QuestionDetailView(),
      binding: QuestionDetailBinding(),
    ),
  ];
}
