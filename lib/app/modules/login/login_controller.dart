import 'package:andin_project/app/core/base/base_controller.dart';
import 'package:andin_project/app/helper/flushbar_helper.dart';
import 'package:andin_project/app/helper/preference_helper.dart';
import 'package:andin_project/app/routes/app_pages.dart';
import 'package:andin_project/app/utils/logger.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final teacherController = TextEditingController();
  final RxBool isTablet = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isTablet.value = PreferenceHelper.isTablet();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> saveTeacherName() async {
    if (teacherController.text.isEmpty) {
      FlushbarHelper.showFlushbar(Get.context!, type: FlushbarType.ERROR, message: 'Teacher Name is required');
      return;
    } else {
      await PreferenceHelper.setTeachersName(teacherController.text);
      logI(PreferenceHelper.getTeacherName());
      _goToAddStudent();
    }
  }

  void _goToAddStudent() => Get.toNamed<dynamic>(Routes.ADD_STUDENT);
}
